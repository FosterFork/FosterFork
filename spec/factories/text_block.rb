FactoryGirl.define do
  factory :text_block do
    name "mystring"
    title "MyString"
    body "MyText body"
    locale I18n.locale
    public true
  end
end
