require 'rails_helper'

RSpec.describe Category, type: :model do

  before(:each) do
    @attrs = {
      name: "Category name",
      color: "#123456",
    }
  end

  it "can be created" do
    expect(Category.new(@attrs)).to be_valid
  end

  it "cannot exist without name" do
    @attrs[:name] = nil
    expect(Category.new(@attrs)).not_to be_valid
  end

  it "cannot exist without a color" do
    @attrs[:color] = nil
    expect(Category.new(@attrs)).not_to be_valid
  end

end
