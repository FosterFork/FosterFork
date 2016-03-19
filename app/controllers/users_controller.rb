class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to edit_user_registration_path
  end

  def projects
  end

end