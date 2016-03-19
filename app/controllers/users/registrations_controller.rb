class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  def edit
    @selected_tab = :settings
    super
  end

  def destroy
    current_password = params[:user][:current_password] rescue nil

    if resource.valid_password?(current_password)
      super
    else
      resource.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      @selected_tab = :delete
      render :edit
    end
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end

  def update_resource(resource, params)
    if params.has_key? :password or params.has_key? :current_password
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end

    if resource.errors.any?
      error_keys = resource.errors.messages&.reject { |k,v| v.empty? }.keys.join(',')
      if error_keys.include? "password"
        @selected_tab = :password
      else
        @selected_tab = :settings
      end
    end
  end

  private

  def check_captcha
    if Settings.recaptcha
      if verify_recaptcha
        true
      else
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    else
      true
    end
  end

end