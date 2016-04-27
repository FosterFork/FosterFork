require 'rails_helper'
require 'support/locale_helpers'
require 'support/mail_helpers'

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

      expect(last_email.subject).to include(I18n.t('devise.mailer.confirmation_instructions.subject'))

      path_regex = /(?:"https?\:\/\/.*?)(\/.*?)(?:")/
      path = last_email.body.match(path_regex)[1]
      expect(path).to_not be_empty
      visit(path)
      expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))

      visit new_user_session_path
      within(:xpath, "//div[@id='main']") do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: password
        click_button I18n.t('devise.sessions.new.sign_in')
      end

      visit edit_user_registration_path
      expect(current_path).to eq(edit_user_registration_path)

      Capybara.reset_sessions!
    end
  end

end
