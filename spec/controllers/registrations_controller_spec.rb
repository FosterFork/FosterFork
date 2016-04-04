require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe Users::RegistrationsController, type: :controller do
  render_views

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#edit" do
    it "shows the #edit template" do
      for_each_locale do
        sign_in nil

        get :edit
        expect(response).to redirect_to new_user_session_path

        post :update, user: { name: "test" }
        expect(response).to redirect_to new_user_session_path

        sign_in FactoryGirl.create(:user)
        get :edit
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#update" do
    it "can update a user account without password" do
      for_each_locale do
        user = FactoryGirl.create(:user)
        password = "password123"
        user.update(password: password)

        sign_in nil
        put :update, user: { name: "test" }
        expect(response).to redirect_to new_user_session_path
        user.reload
        expect(user.name).to_not eq("test")

        sign_in user
        # this must work without entering a password
        put :update, user: { name: "test" }
        expect(response).to have_http_status(:found)
        user.reload
        expect(user.name).to eq("test")
      end
    end
  end

  describe "#update" do
    it "can destroy a user account" do
      for_each_locale do
        user = FactoryGirl.create(:user)
        password = "password123"
        user.update(password: password)

        sign_in nil
        delete :destroy
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path

        sign_in user

        # destroying an account requires the password
        delete :destroy
        expect(response).to have_http_status(:ok)
        expect(response).to render_template :edit
        expect(User.find(user.id)).to be_valid

        delete :destroy, user: { current_password: password }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
        expect(User.where(id: user.id)).to be_empty

        # an oauth authenticated account does not need a password to be destroyed
        #user = FactoryGirl.create(:user)
        #user.update(provider: "diaspora")

        #sign_in user

        #delete :destroy
        #expect(response).to have_http_status(:found)
        #expect(response).to redirect_to root_path
        #expect(User.where(id: user.id)).to be_empty
      end
    end
  end

end
