require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe ProfileController, type: :controller do
  render_views

  describe "#project" do
    it "renders the projects template" do
      for_each_locale do
        user = FactoryGirl.create(:user)

        sign_in nil
        get :projects, profile_id: user.id
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path

        sign_in user
        get :projects, profile_id: user.id
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
