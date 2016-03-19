require 'rails_helper'

RSpec.describe Message, type: :model do

  before(:each) do
    @attrs = {
      project: FactoryGirl.build(:project),
      user: FactoryGirl.build(:user),
    }
  end

  it "can be created" do
    expect(Message.new(@attrs)).to be_valid
  end

  it "cannot exist without project" do
    @attrs[:project] = nil
    expect(Message.new(@attrs)).not_to be_valid
  end

  it "cannot exist without user" do
    @attrs[:user] = nil
    expect(Message.new(@attrs)).not_to be_valid
  end

end
