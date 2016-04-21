require 'rails_helper'

RSpec.describe Inquiry, type: :model do

  before(:each) do
    @attrs = {
      project: FactoryGirl.build(:project),
      user: FactoryGirl.build(:user),
    }
  end

  it "can be created" do
    expect(Inquiry.new(@attrs)).to be_valid
  end

  it "cannot exist without project" do
    @attrs[:project] = nil
    expect(Inquiry.new(@attrs)).not_to be_valid
  end

  it "cannot exist without a user" do
    @attrs[:user] = nil
    expect(Inquiry.new(@attrs)).not_to be_valid
  end

end