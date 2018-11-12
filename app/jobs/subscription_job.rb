class SubscriptionJob < ApplicationJob

  queue_as :default

  def perform
    users = User.where(notification_interval: :weekly).where('last_notified < ?', Time.current.end_of_day - 1.week)
        .or(User.where(notification_interval: :monthly).where('last_notified < ?', Time.current.end_of_day - 1.month))

    users.each { |user| NotificationJob.perform_later(user) }
  end

end
