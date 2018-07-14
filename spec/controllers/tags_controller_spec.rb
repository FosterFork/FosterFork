require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

RSpec.describe TagsController, type: :controller do
  render_views

  describe "#show" do
    it "renders the #show view" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        tag = FactoryGirl.create(:tag)
        project.tags << tag

        get :show, params: { id: tag.to_param }
        expect(response).to render_template :show

        get :show, params: { id: 1234567 }
        expect(response).to redirect_to projects_path
      end
    end
  end

end
