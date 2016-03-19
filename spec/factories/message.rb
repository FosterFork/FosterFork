FactoryGirl.define do
  factory :message do
    project
    user
    title "MyString"
    content "MyText"
  end
end
