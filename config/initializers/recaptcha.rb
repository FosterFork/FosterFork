if Settings.recaptcha
  Recaptcha.configure do |config|
    config.public_key  = Settings.recaptcha.site_key
    config.private_key = Settings.recaptcha.secret_key
    config.use_ssl_by_default = true
  end
end
