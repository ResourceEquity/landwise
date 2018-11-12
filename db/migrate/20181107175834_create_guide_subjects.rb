class CreateGuideSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_subjects do |t|
      t.references :subject, foreign_key: true
      t.references :guide, foreign_key: true

      t.timestamps

      t.index [:guide_id, :subject_id]
      t.index [:subject_id, :guide_id]
    end
  end
end
