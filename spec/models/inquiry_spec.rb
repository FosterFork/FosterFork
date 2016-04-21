require 'rails_helper'
require 'support/mail_helpers'

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

  it "sends an email after creation" do
    inquiry = Inquiry.create(@attrs)
    expect(last_email.to).to eq([inquiry.project.owner.email])
    expect(last_email.reply_to).to eq([inquiry.user.email])
    expect(last_email.subject).to include(inquiry.project.title)
  end

end