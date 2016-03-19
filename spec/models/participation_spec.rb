require 'rails_helper'

RSpec.describe Participation, type: :model do

  before(:each) do
    @attrs = {
      project: FactoryGirl.build(:project),
      user: FactoryGirl.build(:user),
    }
  end

  it "can be created" do
    expect(Participation.new(@attrs)).to be_valid
  end

  it "cannot exist without project" do
    @attrs[:project] = nil
    expect(Participation.new(@attrs)).not_to be_valid
  end

  it "cannot exist without user" do
    @attrs[:user] = nil
    expect(Participation.new(@attrs)).not_to be_valid
  end

end
