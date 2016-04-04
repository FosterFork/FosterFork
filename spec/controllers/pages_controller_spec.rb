require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe PagesController, type: :controller do
  render_views

  describe "#map" do
    it "renders the map template" do
      for_each_locale do
        get :map
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
