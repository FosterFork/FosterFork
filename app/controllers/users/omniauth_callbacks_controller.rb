class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def action_missing(provider)
    unless User.omniauth_providers.include? provider.to_sym
      raise NoMethodError, "undefined OmniAuth provider '#{provider}'"
    end

    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: get_omniauth_setting_for(provider, :pretty_name)) if is_navigational_format?
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end

    def failure
      redirect_to root_path
    end
  end

end
