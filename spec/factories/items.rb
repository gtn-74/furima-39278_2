FactoryBot.define do
  factory :item do
    name { Faker::Name.initials(number: 2) }
    content { Faker::Lorem.sentence }
    category_id              { 5 }
    sale_id                  { 3 }
    shopping_id              { 2 }
    prefecture_id            { 46 }
    shopping_day_id          { 2 }
    price                    { 55_555 }
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
