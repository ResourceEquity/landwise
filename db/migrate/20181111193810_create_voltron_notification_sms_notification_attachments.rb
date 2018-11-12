class CreateVoltronNotificationSmsNotificationAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :voltron_notification_sms_notification_attachments do |t|
      t.integer :sms_notification_id
      t.string :attachment

      t.timestamps null: false
    end
  end
end
