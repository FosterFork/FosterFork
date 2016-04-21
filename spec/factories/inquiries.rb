FactoryGirl.define do
  factory :inquiry do
    user
    project
    content "MyText"
  end
end
