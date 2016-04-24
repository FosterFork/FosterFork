class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    if self.kind_of? ActiveAdmin::BaseController
      I18n.locale = :en
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
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

end
