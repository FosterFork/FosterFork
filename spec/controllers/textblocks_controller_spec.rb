require 'rails_helper'
require 'support/controller_helpers'
require 'support/locale_helpers'

describe TextBlocksController, type: :controller do
  render_views

  describe "#text_blocks" do
    it "accepts requests" do
      for_each_locale do
        block = FactoryGirl.create(:text_block)

        # this has to match an existing route
        block.update(name: "about")

        get block.name
        expect(response).to render_template(:article)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(block.body)
      end
    end
  end

end
