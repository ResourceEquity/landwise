FactoryBot.define do
  
  factory :record do
    title           { FFaker::Lorem.sentence }
    creator         { FFaker::Name.name }
    description     { FFaker::Lorem.paragraph }
    published       { true }
    category
    jurisdiction
  end

end
