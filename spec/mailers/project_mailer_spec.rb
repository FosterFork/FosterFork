require "rails_helper"
require 'support/locale_helpers'

RSpec.describe ProjectMailer, type: :mailer do

  describe "message_mail" do
    it "delivers to the right recipient" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        user = FactoryGirl.create(:user)
        project.participations << Participation.create(user: user)
        participation = project.participations.first

        message = FactoryGirl.create(:message)
        project.messages << message

        mail = ProjectMailer.message_mail(message, participation)

        expect(mail.to).to eq([user.email])
        expect(mail.subject).to include(participation.project.title)
      end
    end
  end

  describe "comment_mail" do
    it "delivers to the right recipient" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        user = FactoryGirl.create(:user)
        project.participations << Participation.create(user: user)
        participation = project.participations.first

        message = FactoryGirl.create(:message)
        project.messages << message

        message.comments << FactoryGirl.create(:comment)
        comment = message.comments.first

        mail = ProjectMailer.comment_mail(comment, participation)

        expect(mail.to).to eq([participation.user.email])
        expect(mail.subject).to include(participation.project.title)
      end
    end
  end

end
