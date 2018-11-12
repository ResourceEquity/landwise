class AddAdminAccounts < ActiveRecord::Migration[4.2]
  def up
    unless User.exists?(email: 'jenniferc@resourceequity.org')
      pw = SecureRandom.hex(48)
      User.create!(first_name: 'Jen', last_name: 'Chang', email: 'jenniferc@resourceequity.org', password: pw)
    end

    unless User.exists?(email: 'jennyrathmell@hotmail.com')
      pw = SecureRandom.hex(48)
      User.create!(first_name: 'Jenny', last_name: 'Rathmell', email: 'jennyrathmell@hotmail.com', password: pw)
    end
  end
end
