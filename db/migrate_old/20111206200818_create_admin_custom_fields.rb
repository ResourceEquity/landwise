class CreateAdminCustomFields < ActiveRecord::Migration[4.2]
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.string :ref_id
      t.integer :position

      t.timestamps
    end
  end
end
