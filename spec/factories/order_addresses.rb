FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id            { 46 }
    city                  { '長崎県' }
    address               { '長崎市' }
    building_name         { 'ビビル' }
    phone_number          { '00000000000' }
    token                 { 'tok_abcdefghijk00000000000000000' }
  end
end
