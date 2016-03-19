require 'rails_helper'
require 'support/controller_helpers'

describe ParticipationsController, type: :controller do
  render_views

  before(:each) do
    @project = FactoryGirl.create(:project)
    @user = FactoryGirl.create(:user)
  end

  describe "#create" do
    it "accepts #create requests" do
      for_each_locale do
        sign_in nil
        post :create, project_id: @project.id
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path

        sign_in @user
        post :create, project_id: @project.id
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to @project

        participation = @user.participations.first
        get :leave, project_id: @project.id, participation_id: participation.id, secret: participation.secret
        expect(@user.participations).to be_empty

        @project.update(public: false)

        post :create, project_id: @project.id
        expect(response).to have_http_status(:forbidden)

        post :create, project_id: @project.id, secret: "x" + @project.secret
        expect(response).to have_http_status(:forbidden)

        post :create, project_id: @project.id, secret: @project.secret
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to @project
      end
    end
  end

end
