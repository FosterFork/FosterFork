require 'rails_helper'

RSpec.describe LayoutImage, type: :model do

  before(:each) do
    @attrs = {
      page: "foo",
      image: File.new(Rails.root.join('spec/files/1x1.jpg')),
      alt: "LayoutImage description ..."
    }
  end

  it "can be created" do
    expect(LayoutImage.new(@attrs)).to be_valid
  end

  it "cannot exist without page name" do
    @attrs[:page] = nil
    expect(LayoutImage.new(@attrs)).not_to be_valid
  end

end
