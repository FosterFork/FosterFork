require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FosterFork
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.time_zone = "UTC"

    # See https://github.com/rails/rails/issues/13164
    # i18n.rb:284:in `enforce_available_locales!': :en is not a valid locale (I18n::InvalidLocale)
    config.i18n.enforce_available_locales = false

    if Settings.locales&.any?
      config.i18n.available_locales = I18n.available_locales & Settings.locales.keys.map(&:to_sym) rescue []
      config.i18n.default_locale = Settings.locales.keys.first
    end

    if Settings.paperclip_options?
      config.paperclip_defaults = Settings.paperclip_options
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true

    raise "No secret key set in the settings file. Aborting." if Settings.secret_key.blank?
  end
end
