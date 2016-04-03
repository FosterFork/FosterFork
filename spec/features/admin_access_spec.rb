require 'rails_helper'

feature 'Admin access', type: :feature do

  scenario "reject non-logged-in users" do
    visit admin_dashboard_path
    expect(current_path).to eq(root_path)
  end

  scenario "reject non-admin users" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    visit admin_dashboard_path
    expect(current_path).to eq(root_path)
  end

  scenario "accept admin users" do
    user = FactoryGirl.create(:user)
    user.is_admin = true
    user.save

    visit new_user_session_path

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    visit admin_dashboard_path
    expect(current_path).to eq(admin_dashboard_path)
  end

end
