require 'rails_helper'

RSpec.describe Translation, type: :model do

  before(:each) do
    @attrs = {
      translatable: FactoryGirl.build(:category),
      title: "Title",
      locale: "Locale"
    }
  end

  it "can be created" do
    expect(Translation.new(@attrs)).to be_valid
  end

  it "cannot exist without title" do
    @attrs[:title] = nil
    expect(Translation.new(@attrs)).not_to be_valid
  end

  it "cannot exist without locale" do
    @attrs[:locale] = nil
    expect(Translation.new(@attrs)).not_to be_valid
  end

end
