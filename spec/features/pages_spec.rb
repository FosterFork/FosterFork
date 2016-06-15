require 'rails_helper'

feature 'View the root page', type: :feature do
  scenario 'user sees relevant page title' do
    visit root_path
    expect(page).to have_title(Settings.platform_name)
  end
end

feature 'View the map', type: :feature do
  scenario 'user sees relevant page title' do
    visit map_path
    expect(page).to have_title(Settings.platform_name)
  end
end
