class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail.from
  layout 'mailer'

  def mail(headers = {}, &block)
    if Settings.mail.subject_prefix
      headers[:subject] = Settings.mail.subject_prefix + headers[:subject]
    end

    super
  end
end
