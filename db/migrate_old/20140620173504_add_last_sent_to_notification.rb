class AddLastSentToNotification < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :last_sent, :datetime
  end
end
