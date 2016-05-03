require "rails_helper"
require 'support/locale_helpers'

RSpec.describe AdminMailer, type: :mailer do

  describe "new_unapproved_project_mail" do
    it "delivers to the right recipient" do
      for_each_locale do
        project = FactoryGirl.create(:project)
        addr = "test@example.com"
        mail = AdminMailer.new_unapproved_project_mail(project, addr)

        expect(mail.to).to eq([addr])
        expect(mail.subject).to include(project.title)
      end
    end
  end

  describe "new_abuse_report_mail" do
    it "delivers to the right recipient" do
      for_each_locale do
        abuse_report = FactoryGirl.create(:abuse_report)
        addr = "test@example.com"
        mail = AdminMailer.new_abuse_report_mail(abuse_report, addr)

        expect(mail.to).to eq([addr])
        expect(mail.subject).to include(abuse_report.project.title)
      end
    end
  end

end
