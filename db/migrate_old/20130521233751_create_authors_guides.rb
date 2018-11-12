class CreateAuthorsGuides < ActiveRecord::Migration[4.2]
  def change
    create_table :authors_guides do |t|
      t.references :guide
      t.references :author
    end 
  end

end