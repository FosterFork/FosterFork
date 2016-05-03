require 'rails_helper'

RSpec.describe Project, type: :model do

  before(:each) do
    @attrs = {
      owner: FactoryGirl.build(:user),
      category: FactoryGirl.build(:category),
      address: "test address 20",
      city: "test city",
      zip: "12345",
      title: Faker::Lorem.sentence.chomp('.').truncate(80),
      abstract: Faker::Hipster.paragraph(3),
      description: Faker::Hipster.paragraph(100),
      country: "en",
      recurrence: "none"
    }
  end

  it "can be created" do
    expect(Project.new(@attrs)).to be_valid
  end

  it "cannot exist without owner" do
    @attrs[:owner] = nil
    expect(Project.new(@attrs)).not_to be_valid
  end

  it "cannot be created with bogus recurrence type" do
    @attrs[:recurrence] = "bogus"
    expect(Project.new(@attrs)).not_to be_valid
  end

  it "is assigned geo coordinates after creation" do
    p = Project.create!(@attrs)
    expect(p.latitude).not_to be(nil)
    expect(p.longitude).not_to be(nil)
  end

  it "is assigned a secret after creation" do
    p = Project.create!(@attrs)
    expect(p.secret).not_to be(nil)
  end

  it "is only publicy visible with correct flags" do
    p1 = Project.create!(@attrs.merge(public: false))
    expect(Project.publicly_visible).not_to include(p1)

    p2 = Project.create!(@attrs.merge(approved: false))
    expect(Project.publicly_visible).not_to include(p2)

    p3 = Project.create!(@attrs.merge(active: false))
    expect(Project.publicly_visible).not_to include(p3)

    @attrs[:public] = true
    @attrs[:approved] = true
    @attrs[:active] = true

    p4 = Project.create!(@attrs.merge(date: Time.now - 1.day))
    expect(Project.publicly_visible).not_to include(p4)

    p5 = Project.create!(@attrs.merge(date: Time.now + 1.day))
    expect(Project.publicly_visible).to include(p5)

    p6 = Project.create!(@attrs.merge(date: Time.now - 1.day, recurrence: "daily"))
    expect(Project.publicly_visible).to include(p6)
  end

  it "calculates the next date correctly" do
    p = Project.new(@attrs)
    now = Time.now
    p.date = now - 5.hours

    p.recurrence = "daily"
    expect(p.next_date.to_i).to be_equal((now + 19.hours).to_i)

    p.recurrence = "weekly"
    expect(p.next_date.to_i).to be_equal((now + 6.days + 19.hours).to_i)

    p.recurrence = "biweekly"
    expect(p.next_date.to_i).to be_equal((now + 13.days + 19.hours).to_i)

    p.recurrence = "monthly"
    expect(p.next_date.to_i).to be_equal((now + 1.month - 1.day + 19.hours).to_i)
  end

  it "is only visible by appropriate users" do
    stranger = FactoryGirl.build(:user)
    admin = FactoryGirl.build(:user)
    owner = FactoryGirl.build(:user)
    admin.is_admin = true

    p = Project.new(@attrs)
    p.owner = owner
    p.generate_secret!

    p.public = true
    p.approved = true
    p.active = true

    expect(p.accessible_by?(owner, p.secret)).to be(true)
    expect(p.accessible_by?(owner, nil)).to be(true)
    expect(p.accessible_by?(stranger, nil)).to be(true)
    expect(p.accessible_by?(stranger, p.secret)).to be(true)
    expect(p.accessible_by?(admin, nil)).to be(true)
    expect(p.accessible_by?(nil, nil)).to be(true)
    expect(p.accessible_by?(nil, p.secret)).to be(true)

    p.active = false
    p.approved = false

    expect(p.accessible_by?(owner, p.secret)).to be(true)
    expect(p.accessible_by?(owner, nil)).to be(true)
    expect(p.accessible_by?(stranger, nil)).to be(false)
    expect(p.accessible_by?(stranger, p.secret)).to be(false)
    expect(p.accessible_by?(admin, nil)).to be(true)
    expect(p.accessible_by?(nil, nil)).to be(false)
    expect(p.accessible_by?(nil, p.secret)).to be(false)

    p.active = true
    p.approved = true
    p.public = false

    expect(p.accessible_by?(owner, p.secret)).to be(true)
    expect(p.accessible_by?(owner, nil)).to be(true)
    expect(p.accessible_by?(stranger, nil)).to be(false)
    expect(p.accessible_by?(stranger, p.secret)).to be(true)
    expect(p.accessible_by?(admin, nil)).to be(true)
    expect(p.accessible_by?(nil, nil)).to be(false)
    expect(p.accessible_by?(nil, p.secret)).to be(true)
  end

  it "returns correct values for last_update" do
    p = Project.create!(@attrs)
    expect(p.last_update).to eq(p.updated_at)

    ma = FactoryGirl.create(:message)
    ma.updated_at = Time.now + 1.hour

    mb = FactoryGirl.create(:message)
    mb.updated_at = Time.now + 2.hours

    mc = FactoryGirl.create(:message)
    mc.updated_at = Time.now + 3.hours

    p.messages << ma
    p.messages << mb
    p.messages << mc

    expect(p.last_update).to eq(mc.updated_at)
  end

  it "can create a new secret" do
    p = Project.create!(@attrs)
    secret = p.secret
    expect(secret).not_to be_empty

    p.generate_secret!
    expect(p.secret).not_to be_equal(secret)
  end

  it "sends an admin notification email after creation" do
    @attrs[:approved] = false
    project = Project.create(@attrs)

    expect(last_email.to).to eq([Settings.notification_emails.new_unapproved_project])
    expect(last_email.subject).to include(project.title)
  end

  it "sends an email after approval" do
    @attrs[:approved] = false
    project = Project.create(@attrs)

    project.approved = true
    project.save

    expect(last_email.to).to eq([project.owner.email])
    expect(last_email.subject).to include(project.title)
  end

end
