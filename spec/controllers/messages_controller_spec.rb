require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe MessagesController, type: :controller do
  render_views

  before(:each) do
    @project = FactoryGirl.create(:project)
  end

  describe "#create" do
    it "accepts #create requests" do
      for_each_locale do
        sign_in nil
        post :create, params: {
          project_id: @project.id,
          message: { title: "foo", content: "bar" }
        }
        expect(response).to redirect_to new_user_session_path

        sign_in @project.owner
        post :create, params: {
          project_id: @project.id,
          message: { title: "foo", content: "bar" }
        }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "#destroy" do
    it "accepts #destroy requests" do
      for_each_locale do
        message = FactoryGirl.create(:message)
        message.project = @project
        message.save!

        sign_in nil
        delete :destroy, params: {
          project_id: @project.id,
          id: message.id
        }
        expect(response).to redirect_to new_user_session_path

        sign_in @project.owner
        delete :destroy, params: {
          project_id: @project.id,
          id: message.id
        }
        expect(response).to have_http_status(:found)
      end
    end
  end

end
