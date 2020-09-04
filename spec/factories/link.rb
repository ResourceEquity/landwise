FactoryBot.define do
  
  factory :link do
    url { FFaker::Internet.http_url }

    trait :valid do
      code { rand(200..299) }
    end
    
    trait :invalid do
      code { rand(300..601) }
    end
  end

end
