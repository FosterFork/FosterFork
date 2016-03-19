class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_friendly
  before_action :authenticate_owner!

  def create
    message = Message.new(permitted_params)
    message.project = @project
    message.user = current_user
    message.save!
    redirect_to @project, flash: { success: t('message.created') }
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy if message
    redirect_to @project, flash: { success: t('message.deleted') }
  end

  private

  def find_project_friendly
    begin
      @project = Project.friendly.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, flash: { error: t('project.not_found') }
    end
  end

  def authenticate_owner!
    if @project.owner != current_user
      redirect_to @project, status: :forbidden
    end
  end

  def permitted_params
    params[:message].permit([ :title, :content ])
  end

end