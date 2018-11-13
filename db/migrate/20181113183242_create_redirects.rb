class CreateRedirects < ActiveRecord::Migration[5.2]
  def change
    create_table :redirects do |t|
      t.string :from
      t.string :to

      t.timestamps
    end

    add_index :redirects, :from, unique: true
  end
end
