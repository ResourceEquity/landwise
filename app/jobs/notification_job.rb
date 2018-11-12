class NotificationJob < ApplicationJob

  queue_as :default

  def perform(user)
    return if user.never?

    search = Record.search do
      fulltext '*'

      if user.weekly?
        with(:created_at).greater_than(Time.current.end_of_day - 1.week)
      elsif user.monthly?
        with(:created_at).greater_than(Time.current.end_of_day - 1.month)
      end

      any do
        with :country_ids,      user.topics.map(&:id)
        with :topic_ids,        user.countries.map(&:id)
        with :language_ids,     user.languages.map(&:id)
        with :jurisdiction_id,  user.jurisdictions.map(&:id)
        with :category_id,      user.categories.map(&:id)
      end
    end

    if search.results.any?
      user.notifications.create do |n|
        n.email 'Recently added records from LandWise', { records: search.results } do
          template 'records/mailer/added'
        end.deliver_later
      end
    end
  end
end
