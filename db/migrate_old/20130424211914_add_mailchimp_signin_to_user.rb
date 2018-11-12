class AddMailchimpSigninToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mailchimp_signin, :boolean
  end
end
