FactoryGirl.define do
  factory :abuse_report do
    project
    user
    reason "Blah"
  end
end
