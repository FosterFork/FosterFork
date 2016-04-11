class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_friendly
  before_action :authenticate_owner!

  def create
    image = Image.new(permitted_params)
    image.project = @project
    image.save!
    redirect_to @project, flash: { success: t('image.created') }
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to @project, flash: { success: t('image.deleted') }
  end

  private

  def find_project_friendly
    @project = Project.friendly.find(params[:project_id])
  end

  def authenticate_owner!
    if @project.owner != current_user
      redirect_to @project, status: :forbidden
    end
  end

  def permitted_params
    params[:image].permit([ :image, :alt ])
  end

end