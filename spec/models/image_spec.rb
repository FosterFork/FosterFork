require 'rails_helper'

RSpec.describe Image, type: :model do

  before(:each) do
    @attrs = {
      project: FactoryGirl.build(:project),
      image: File.new(Rails.root.join('spec/files/1x1.jpg')),
      alt: "Image description ..."
    }
  end

  it "can be created" do
    expect(Image.new(@attrs)).to be_valid
  end

  it "cannot exist without project" do
    @attrs[:project] = nil
    expect(Image.new(@attrs)).not_to be_valid
  end

end
