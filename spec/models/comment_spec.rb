require 'rails_helper'

RSpec.describe Comment, type: :model do

  before(:each) do
    @attrs = {
      message: FactoryGirl.build(:message),
      user: FactoryGirl.build(:user),
    }
  end

  it "can be created" do
    expect(Comment.new(@attrs)).to be_valid
  end

  it "cannot exist without message" do
    @attrs[:message] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  it "cannot exist without user" do
    @attrs[:user] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  it "can be deleted by appropriate users" do
    c = Comment.create(@attrs)
    admin = FactoryGirl.create(:user)
    admin.update_attribute(:is_admin, true)

    expect(c.can_be_deleted_by?(c.user)).to be true
    expect(c.can_be_deleted_by?(c.message.user)).to be true
    expect(c.can_be_deleted_by?(c.message.project.owner)).to be true
    expect(c.can_be_deleted_by?(admin)).to be true
    expect(c.can_be_deleted_by?(FactoryGirl.create(:user))).to be false
  end

  it "sends an email after creation" do
    participation = FactoryGirl.create(:participation)
    project = participation.project

    project.messages << FactoryGirl.create(:message)
    @attrs[:message] = project.messages.first

    reset_email
    comment = Comment.create(@attrs)

    expect(email(0).to).to eq([project.owner.email])
    expect(email(0).subject).to include(comment.message.title)
    expect(email(1).to).to eq([participation.user.email])
  end

end
