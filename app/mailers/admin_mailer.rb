class AdminMailer < ApplicationMailer

  def new_unapproved_project_mail(project, recipient)
    @project = project
    mail(to: recipient, subject: "New unapproved project: #{@project.title}")
  end

  def new_abuse_report_mail(abuse_report, recipient)
    @abuse_report = abuse_report
    @project = abuse_report.project
    mail(to: recipient, subject: "New abuse report about: #{@project.title}")
  end

end
