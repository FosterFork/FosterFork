require 'rails_helper'

RSpec.describe Tag, type: :model do

  before(:each) do
    @attrs = {
      name: "Tag name",
      color: "#123456",
    }
  end

  it "can be created" do
    expect(Tag.new(@attrs)).to be_valid
  end

  it "cannot exist without name" do
    @attrs[:name] = nil
    expect(Tag.new(@attrs)).not_to be_valid
  end

  it "cannot exist without a color" do
    @attrs[:color] = nil
    expect(Tag.new(@attrs)).not_to be_valid
  end

end
