require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe ProjectsController, type: :controller do
  render_views

  describe "#index" do
    it "renders the #index view" do
      for_each_locale do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "#show" do
    it "renders the #show view" do
      for_each_locale do
        project = FactoryGirl.create(:project)

        sign_in nil

        get :show, id: project.id
        expect(response).to render_template :show

        get :show, id: 1234567
        expect(response).to redirect_to projects_path

        project.update(public: false)
        get :show, id: project.id
        expect(response).to have_http_status(:forbidden)

        sign_in project.owner
        get :show, id: project.id
        expect(response).to render_template :show
      end
    end
  end

  describe "#new" do
    it "renders the #new view" do
      for_each_locale do
        sign_in nil
        get :new
        expect(response).to_not render_template :new

        sign_in FactoryGirl.create(:user)
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "#destroy" do
    it "accepts #destroy requests" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        stranger = FactoryGirl.create(:user)

        sign_in nil
        delete :destroy, id: project.id
        expect(response).to have_http_status(:forbidden)

        sign_in stranger
        delete :destroy, id: project.id
        expect(response).to have_http_status(:forbidden)

        sign_in project.owner
        delete :destroy, id: project.id
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "#update" do
    it "accepts #update requests" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        stranger = FactoryGirl.create(:user)

        sign_in nil
        put :update, id: project.id, project: {}
        expect(response).to have_http_status(:forbidden)

        sign_in stranger
        put :update, id: project.id, project: {}
        expect(response).to have_http_status(:forbidden)

        sign_in project.owner
        put :update, id: project.id, project: {}
        expect(response).to have_http_status(:found)

        sign_in project.owner
        project.update(approved: false)

        put :update, id: project.id, project: { approved: true }
        expect(response).to have_http_status(:found)
        project.reload
        expect(project.approved).to be(false)

        put :update, id: project.id, project: { public: false }
        expect(response).to have_http_status(:found)
        project.reload
        expect(project.approved).to be(false)
      end
    end
  end

end
