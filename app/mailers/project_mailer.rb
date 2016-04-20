class ProjectMailer < ApplicationMailer

  def approved_mail(project)
    @project = project
    subject = I18n.t('mailer.approved.subject', project_title: @project.title)
    mail(to: @project.owner.email, subject: subject, locale: @project.owner.locale)
  end

  def message_mail(message, participation)
    @participation = participation
    @project = participation.project
    @user = participation.user
    @message = message

    subject = I18n.t('mailer.message.subject',
                     project_title: @project.title,
                     message_title: @message.title)

    mail(to: @user.email, subject: subject, locale: @user.locale)
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

    mail(to: @user.email, subject: subject, locale: @user.locale)
  end

  def new_project_near_you_mail(project, user)
    @project, @user = project, user
    subject = I18n.t('mailer.new_project_near_you.subject', project_title: @project.title)
    mail(to: @user.email, subject: subject, locale: @user.locale)
  end

end
