class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail.from
  layout 'mailer'

  def mail(headers = {}, &block)
    if Settings.mail.subject_prefix
      headers[:subject] = Settings.mail.subject_prefix + headers[:subject]
    end

    locale = headers.delete(:locale) || I18n.default_locale
    I18n.with_locale(locale) { super }
  end
end
