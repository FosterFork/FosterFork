require 'rails_helper'
require 'support/locale_helpers'

feature 'User signin', type: :feature do

  scenario "reject non-logged-in users access to profile" do
    for_each_locale do
      visit edit_user_registration_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

  scenario "rejects wrong passwords" do
    for_each_locale do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      within(:xpath, "//div[@id='main']") do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: "wrongwrongwrong"
        click_button I18n.t('devise.sessions.new.sign_in')
      end

      expect(current_path).to eq(new_user_session_path)

      visit edit_user_registration_path
      expect(current_path).to eq(new_user_session_path)

      Capybara.reset_sessions!
    end
  end

  scenario "user can sign in" do
    for_each_locale do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      within(:xpath, "//div[@id='main']") do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
      end

      expect(current_path).to eq(root_path)

      visit edit_user_registration_path
      expect(current_path).to eq(edit_user_registration_path)

      Capybara.reset_sessions!
    end
  end

  scenario "user can sign in trough modal" do
    for_each_locale do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      within(:xpath, "//div[@id='signInModal']") do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
      end

      expect(current_path).to eq(root_path)

      visit edit_user_registration_path
      expect(current_path).to eq(edit_user_registration_path)

      Capybara.reset_sessions!
    end

  end

end
