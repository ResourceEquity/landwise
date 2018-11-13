class NotificationJob < ApplicationJob

  queue_as :default

  def perform(user)
    return if user.never?

    search = Record.search do
      fulltext '*'

      with(:created_at).greater_than(user.last_notified)
      with :published, true
      with :roles, user.responsibilities.map(&:id)

      any_of do
        with :country_ids,  user.topics.map(&:id)
        with :topic_ids,    user.countries.map(&:id)
        with :language_ids, user.languages.map(&:id)

        user.jurisdictions.each do |jurisdiction|
          with :jurisdiction_id, jurisdiction.id
        end
        user.categories.each do |category|
          with :category_id, category.id
        end
      end
    end

    if search.results.any?
      user.notifications.create do |n|
        n.email 'Recently added records from LandWise', { records: search.results } do
          template 'records/mailer/added'
        end.deliver_later
      end
    end

    user.last_notified = Time.current
    user.save(validate: false)
  end
end
