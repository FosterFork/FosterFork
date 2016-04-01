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

  it "can be deleted by appropriate users" do
    m = Message.create(@attrs)
    admin = FactoryGirl.create(:user)
    admin.update_attribute(:is_admin, true)

    expect(m.can_be_deleted_by?(m.user)).to be true
    expect(m.can_be_deleted_by?(m.project.owner)).to be true
    expect(m.can_be_deleted_by?(admin)).to be true
    expect(m.can_be_deleted_by?(FactoryGirl.create(:user))).to be false
  end

end
