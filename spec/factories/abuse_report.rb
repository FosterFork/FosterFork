FactoryGirl.define do
  factory :abuse_report do
    project
    association :reporter, factory: :user
    reason "Blah"
  end
end
