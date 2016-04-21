class ProjectMailer < ApplicationMailer

  def approved_mail(project)
    @project = project

    locale = @project.owner.locale || I18n.default_locale
    I18n.with_locale(locale) do
      subject = I18n.t('mailer.approved.subject', project_title: @project.title)
      mail(to: @project.owner.email, subject: subject)
    end
  end

  def message_mail(message, participation)
    @participation = participation
    @project = participation.project
    @user = participation.user
    @message = message

    locale = @user.locale || I18n.default_locale
    I18n.with_locale(locale) do
      subject = I18n.t('mailer.message.subject',
                       project_title: @project.title,
                       message_title: @message.title)

      mail(to: @user.email, subject: subject)
    end
  end

  def comment_mail(comment, project, user, participation)
    @comment = comment
    @project = project
    @user = user
    @participation = participation

    locale = @user.locale || I18n.default_locale
    I18n.with_locale(locale) do
      subject = I18n.t('mailer.comment.subject',
                       project_title: @project.title,
                       message_title: @comment.message.title,
                       author: @comment.user.name)

      mail(to: @user.email, subject: subject, locale: @user.locale)
    end
  end

  def new_project_near_you_mail(project, user)
    @project, @user = project, user
    locale = @user.locale || I18n.default_locale
    I18n.with_locale(locale) do
      subject = I18n.t('mailer.new_project_near_you.subject', project_title: @project.title)
      mail(to: @user.email, subject: subject, locale: @user.locale)
    end
  end

  def inquiry_mail(inquiry)
    @inquiry = inquiry
    @sender = inquiry.user
    @recipient = inquiry.project.owner
    @project = inquiry.project

    locale = @recipient.locale || I18n.default_locale
    I18n.with_locale(locale) do
      subject = I18n.t('mailer.inquiry.subject', author: @sender.name, project_title: @project.title)
      mail(to: @recipient.email, reply_to: @sender.email, subject: subject, locale: @recipient.locale)
    end
  end

end
