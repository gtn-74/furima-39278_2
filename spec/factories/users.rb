FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    birth_day { '1990-01-01' }
    password              { '1a' + Faker::Internet.password(min_length: 5) }
    password_confirmation { password }
    family_name { '扇谷' }
    first_name { 'りょうすけ' }
    family_name_kana { 'オウギタニ' }
    first_name_kana { 'リョウスケ' }
  end
end
