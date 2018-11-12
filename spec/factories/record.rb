FactoryBot.define do
  
  factory :record do
    title           { FFaker::Lorem.sentence }
    creator         { FFaker::Name.name }
    description     { FFaker::Lorem.paragraph }
    published       { true }
    category_id     { Category.sample.id }
    jurisdiction_id { Jurisdiction.sample.id }
    user_id         { User.sample.id }
  end

end
