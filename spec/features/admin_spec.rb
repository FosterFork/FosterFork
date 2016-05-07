require 'rails_helper'
require 'support/controller_helpers'

feature 'Admin pages', type: :feature do

  before(:each) do
    user = FactoryGirl.create(:user)
    user.is_admin = true
    user.save

    visit new_user_session_path

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button I18n.t('devise.sessions.new.sign_in')
    end
  end

  scenario "dashboard" do
    visit admin_dashboard_path
    expect(current_path).to eq(admin_dashboard_path)
  end

  scenario "abuse reports" do
    ar = FactoryGirl.create(:abuse_report)

    visit admin_abuse_reports_path
    expect(current_path).to eq(admin_abuse_reports_path)
    expect(page).to have_content(ar.project.title)

    visit admin_abuse_report_path(ar)
    expect(current_path).to eq(admin_abuse_report_path(ar))
    expect(page).to have_content(ar.project.title)
  end

  scenario "categories" do
    c = FactoryGirl.create(:category)

    visit admin_categories_path
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_content(c.name)

    visit admin_category_path(c)
    expect(current_path).to eq(admin_category_path(c))
    expect(page).to have_content(c.name)
  end

  scenario "images" do
    i = FactoryGirl.create(:image)

    visit admin_images_path
    expect(current_path).to eq(admin_images_path)
    expect(page).to have_content(i.alt)

    visit admin_image_path(i)
    expect(current_path).to eq(admin_image_path(i))
    expect(page).to have_content(i.alt)
  end

  scenario "inquiries" do
    i = FactoryGirl.create(:inquiry)

    visit admin_inquiries_path
    expect(current_path).to eq(admin_inquiries_path)
    expect(page).to have_content(i.project.title)

    visit admin_inquiry_path(i)
    expect(current_path).to eq(admin_inquiry_path(i))
    expect(page).to have_content(i.project.title)
  end

  scenario "projects" do
    p = FactoryGirl.create(:project)

    visit admin_projects_path
    expect(current_path).to eq(admin_projects_path)
    expect(page).to have_content(p.title)

    visit admin_project_path(p)
    expect(current_path).to eq(admin_project_path(p))
    expect(page).to have_content(p.title)
  end

  scenario "text blocks" do
    tb = FactoryGirl.create(:text_block)

    visit admin_text_blocks_path
    expect(current_path).to eq(admin_text_blocks_path)
    expect(page).to have_content(tb.name)

    visit admin_text_block_path(tb)
    expect(current_path).to eq(admin_text_block_path(tb))
    expect(page).to have_content(tb.name)
  end

  scenario "text blocks" do
    u = FactoryGirl.create(:user)

    visit admin_users_path
    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content(u.name)

    visit admin_user_path(u)
    expect(current_path).to eq(admin_user_path(u))
    expect(page).to have_content(u.name)
  end

end
