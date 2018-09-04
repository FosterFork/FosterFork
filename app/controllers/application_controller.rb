class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = locale_for_request
  end

  def default_url_options(options = {})
    self.class.default_url_options options
  end

  def authenticate_admin_user!
    redirect_to root_path unless user_signed_in? and current_user.is_admin?
  end

  def configure_permitted_parameters
    allowed_for_user = [ :email, :password, :password_confirmation, :current_password,
                         :name, :phone, :newsletter, :project_proximity,
                         :zip, :country, :terms, :locale ]
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(allowed_for_user) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(allowed_for_user) }
  end

  class << self
    def default_url_options(options = {})
      if I18n.available_locales.length > 1 and not self.kind_of? ActiveAdmin::BaseController
        options[:locale] = I18n.locale
      end

      options
    end
  end

  private

  def locale_for_request
    return :en if self.kind_of? ActiveAdmin::BaseController

    if params[:locale].present? and I18n.available_locales.include? params[:locale].to_sym
      return params[:locale]
    end

    http_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first rescue nil
    if I18n.available_locales.include? http_locale&.to_sym
      return http_locale
    end

    I18n.default_locale
  end

end
