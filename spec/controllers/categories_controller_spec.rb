require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe CategoriesController, type: :controller do
  render_views

  describe "#show" do
    it "renders the #show view" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        category = project.category

        get :show, params: { id: category.to_param }
        expect(response).to render_template :show

        get :show, params: { id: 1234567 }
        expect(response).to redirect_to projects_path
      end
    end
  end

end
