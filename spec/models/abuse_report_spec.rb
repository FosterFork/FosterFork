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

  it "sends an admin notification email after creation" do
    ar = AbuseReport.create(@attrs)
    expect(last_email.to).to eq([Settings.notification_emails.new_abuse_report])
    expect(last_email.subject).to include(ar.project.title)
  end

end
