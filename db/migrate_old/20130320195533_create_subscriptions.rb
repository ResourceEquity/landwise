class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.string :category
      t.string :term

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
