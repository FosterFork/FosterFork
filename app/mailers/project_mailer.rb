class ProjectMailer < ApplicationMailer

  def message_mail(message, participation)
    @participation = participation
    @project = participation.project
    @user = participation.user
    @message = message

    subject = I18n.t('mailer.message.subject',
                     project_title: @project.title,
                     message_title: @message.title)

    mail(to: @user.email, subject: subject)
  end

  def comment_mail(comment, participation)
    @participation = participation
    @project = participation.project
    @user = participation.user
    @comment = comment

    subject = I18n.t('mailer.comment.subject',
                     project_title: @project.title,
                     message_title: @comment.message.title,
                     author: @comment.user.name)

    mail(to: @user.email, subject: subject)
  end

end
