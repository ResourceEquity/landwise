class CreateSubjectsGuides < ActiveRecord::Migration[4.2]
  def change
          create_table :guides_subjects do |t|
                  t.references :guide
                  t.references :subject 
          end        
  end
end