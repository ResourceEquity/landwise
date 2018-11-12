class DeleteAllUsers < ActiveRecord::Migration[4.2]
  def up
    User.where.not(email: ['jenniferc@resourceequity.org', 'jennyrathmell@hotmail.com', 'support@commercekitchen.com']).destroy_all
  end
end
