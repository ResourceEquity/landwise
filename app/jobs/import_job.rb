require 'csv'

class ImportJob < ApplicationJob

  attr_reader :import

  queue_as :priority

  rescue_from StandardError do |error|
    import.import_errors.create(message: error.message)
    notify
  end

  def perform(import)
    @import = import

    unless ['text/csv', 'application/vnd.ms-excel'].include?(@import.import.content_type)
      raise Import::DocumentNotValid, 'Upload was not recognized as a valid CSV document.'
    end

    @import.update(total: csv.length)

    completed = 0
    csv.each.with_index(1) do |row, line|
      completed += 1 if insert(row, line)
    end

    @import.update(complete: completed)
    notify
  end

  private

    def notify
      @import.user.notifications.create do |n|
        n.email "Import of #{@import.import.blob.filename} has finished", { import: @import } do
          template 'admin/imports/mailer/finished'
        end.deliver_later
      end
    end

    def csv
      @csv ||= CSV.parse(open(import.import.service_url), headers: true, encoding: 'UTF-8', skip_blanks: true)
    end

    def insert(row, line)
      category          = Category.find_or_create_by(title: row['record_collection_type'])
      jurisdiction      = Jurisdiction.find_or_create_by(title: row['jurisdiction'])
      topics            = row['topics'].to_s.split(',').map { |topic| Topic.find_or_create_by(title: topic.strip) }
      countries         = row['record_countries'].to_s.split(',').map { |country| Country.find_or_create_by(title: country.strip) }
      languages         = row['language'].to_s.split(',').map { |language| Language.find_or_create_by(title: language.strip) }
      responsibilities  = row['roles'].to_s.split(',').map { |role| Responsibility.where('LOWER(title) = ?', role).first }.compact

      record = Record.new(
        title:            row['record_title'],
        creator:          row['creator'],
        description:      row['record_description'],
        published:        row['published'].to_s.downcase == 'true' ? true : false,
        author:           row['record_author'],
        notes:            row['staff_notes'],
        topic_ids:        topics.map(&:id),
        country_ids:      countries.map(&:id),
        category:         category,
        jurisdiction:     jurisdiction,
        responsibilities: (responsibilities.to_a + [admin]).uniq
      )

      item = record.items.build(
        title:        row['item_title'],
        description:  row['item_description'],
        url:          row['url'],
        year:         row['publication_year'],
        published:    row['published'].to_s.downcase == 'true' ? true : false,
        language_ids: languages.map(&:id)
      )

      record.save!
    rescue ActiveRecord::RecordInvalid => e
      import.import_errors.create(message: e.message, trace: e.backtrace.join("\r\n"), row: row.to_s, line: line)
      false
    end

    def admin
      @admin ||= Responsibility.find_by(title: 'Admin')
    end

end
