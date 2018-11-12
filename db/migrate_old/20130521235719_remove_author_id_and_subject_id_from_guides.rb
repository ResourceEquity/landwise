class RemoveAuthorIdAndSubjectIdFromGuides < ActiveRecord::Migration[4.2]
  def change
    remove_column :guides, :author_id, :subject_id
  end
end