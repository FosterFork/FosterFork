FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    name "John Doe"
    newsletter true

    locale "en"
    phone "123456789"
    zip "12345"
    country "de"

    password "123123123"
    password_confirmation "123123123"

    confirmed_at Time.now

    terms "1"
  end
end
