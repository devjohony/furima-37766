FactoryBot.define do
  factory :purchase_address do
    token { 'eovnieonvievsa' }
    postal_code { '777-7777' }
    prefecture_id { Faker::Number.within(range: 1..2) }
    municipality { Gimei.address.city.kanji }
    address { Gimei.address.town.kanji }
    building { Faker::Address.street_address }
    phone_number { '00000000000' }

  end
end