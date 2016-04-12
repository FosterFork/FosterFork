[:smtp_settings, :delivery_method, :default_url_options].each do |key|
  if Settings.mail[key]
    ActionMailer::Base.send(:"#{key}=",
      Settings.mail[key].is_a?(Symbol) ? Settings.mail[key] : Settings.mail[key].to_hash)
  end
end
