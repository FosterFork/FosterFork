require 'rails_helper'

feature 'Profile editor', type: :feature do

  scenario "user can edit profile settings" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    visit edit_user_registration_path

    name = "hackenborsch"
    within(:xpath, "//div[@id='settings']") do
      fill_in "user[name]", with: name
      click_button I18n.t('save')
    end

    user.reload
    expect(user.name).to eq(name)
  end

  scenario "user can change password" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    visit edit_user_registration_path

    password = "password123123"
    within(:xpath, "//div[@id='password']") do
      fill_in "user[current_password]", with: user.password
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password
      click_button I18n.t('save')
    end

    expect(current_path).to eq(new_user_session_path)

    within(:xpath, "//div[@id='main']") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    visit edit_user_registration_path
    expect(current_path).to eq(edit_user_registration_path)
  end

end
