class Users::SessionsController < Devise::SessionsController

  def create
    super do |user|
      I18n.locale = user.locale
    end
  end

end