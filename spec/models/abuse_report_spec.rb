require 'rails_helper'

RSpec.describe AbuseReport, type: :model do

  before(:each) do
    @attrs = {
      project: FactoryGirl.build(:project),
      reporter: FactoryGirl.build(:user),
    }
  end

  it "can be created" do
    expect(AbuseReport.new(@attrs)).to be_valid
  end

  it "cannot exist without project" do
    @attrs[:project] = nil
    expect(AbuseReport.new(@attrs)).not_to be_valid
  end

  it "can exist without a reporter" do
    @attrs[:reporter] = nil
    expect(AbuseReport.new(@attrs)).to be_valid
  end

  it "is unresolved by default" do
    ar = AbuseReport.create(@attrs)
    expect(ar.resolver).to be(nil)
  end

end
