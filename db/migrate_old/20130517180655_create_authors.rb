class CreateAuthors < ActiveRecord::Migration[4.2]
  def change
    create_table :authors do |t|
      t.string(:first_name, :null => false)
      t.string(:last_name, :null => false)
      t.string(:title, :null => false)
      t.string(:email, :null => false)

      t.timestamps
    end
  end
end 