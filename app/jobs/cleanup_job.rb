class CleanupJob < ApplicationJob

  queue_as :default

  def perform
    User.where(confirmed_at: nil).where('created_at < ?', Time.current.beginning_of_day - Devise.confirm_within).destroy_all
  end

end
