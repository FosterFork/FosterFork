require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe AbuseReportsController, type: :controller do
  render_views

  before(:each) do
    @project = FactoryGirl.create(:project)
  end

  describe "#new" do
    it "renders the #new view" do
      for_each_locale do
        sign_in nil
        get :new, project_id: @project.id
        expect(response).to render_template :new

        sign_in FactoryGirl.create(:user)
        get :new, project_id: @project.id
        expect(response).to render_template :new
      end
    end
  end

  describe "#create" do
    it "accepts #create requests" do
      for_each_locale do
        post :create, project_id: @project.id, abuse_report: { reason: "blah" }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to project_path(@project)
      end
    end
  end

end
