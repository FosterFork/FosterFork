require "rails_helper"

RSpec.describe ProjectMailer, type: :mailer do

  describe "message_mail" do
    it "delivers to the right recipient" do
      participation = FactoryGirl.create(:participation)
      participation.project.messages << FactoryGirl.create(:message)
      message = participation.project.messages.first

      mail = ProjectMailer.message_mail(message, participation)

        expect(mail.to).to eq([participation.user.email])
    end
  end

end
