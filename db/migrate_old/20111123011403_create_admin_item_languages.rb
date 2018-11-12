class CreateAdminItemLanguages < ActiveRecord::Migration[4.2]
  def change
    create_table :item_languages do |t|
      t.string :name
    end
  end
end
