require 'rails_helper'
require 'support/controller_helpers'

describe CommentsController, type: :controller do
  render_views

  before(:each) do
    @message = FactoryGirl.create(:message)
  end

  describe "#create" do
    it "accepts #create requests" do
      for_each_locale do
        sign_in nil
        post :create, project_id: @message.project.id, message_id: @message.id, comment: { content: "bar" }
        expect(response).to redirect_to new_user_session_path

        sign_in @message.project.owner
        post :create, project_id: @message.project.id, message_id: @message.id, comment: { content: "bar" }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "#destroy" do
    it "accepts #destroy requests" do
      for_each_locale do
        comment = FactoryGirl.create(:comment)
        comment.message = @message
        comment.save!

        sign_in nil
        delete :destroy, project_id: @message.project.id, message_id: @message.id, id: comment.id
        expect(response).to redirect_to new_user_session_path

        sign_in @message.project.owner
        delete :destroy, project_id: @message.project.id, message_id: @message.id, id: comment.id
        expect(response).to have_http_status(:found)
      end
    end
  end

end
