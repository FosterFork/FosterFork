require 'rails_helper'
require 'support/locale_helpers'

feature 'User signup', type: :feature do

  scenario "new user signs up" do
    for_each_locale do
      visit new_user_registration_path
      expect(current_path).to eq(new_user_registration_path)

      user = FactoryGirl.build(:user)
      password = "123123123123"

      within(:xpath, "//div[@id='main']") do
        fill_in "user[email]", with: user.email
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: password
        fill_in "user[password_confirmation]", with: password
        check "user[terms]"
        click_button I18n.t('devise.registrations.new.sign_up')
      end

      visit edit_user_registration_path
      expect(current_path).to eq(edit_user_registration_path)

      Capybara.reset_sessions!
    end
  end

end
