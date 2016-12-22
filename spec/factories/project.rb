FactoryGirl.define do
  sequence :title do |n|
    "project title title title#{n}"
  end

  factory :project do
    association :owner, factory: :user
    category
    title
    date Time.now
    abstract Faker::Hipster.paragraph(3)
    description Faker::Hipster.paragraph(100)
    recurrence "none"
    secret SecureRandom.hex(16)
    address "main street 11"
    city "New York"
    zip "12345"
    country "de"
    public true
    approved true
    active true
    inquiries_allowed true
    longitude 12.34567
  end
end
