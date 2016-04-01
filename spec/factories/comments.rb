FactoryGirl.define do
  factory :comment do
    user
    message
    content "MyText"
  end
end
