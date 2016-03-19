class ParticipationsController < ApplicationController
  before_action :authenticate_user!, except: [ :leave ]
  before_action :find_project_friendly

  def create
    Participation.where(project: @project, user: current_user).first_or_create
    redirect_to @project, flash: { success: t('participation.joined') }
  end

  def destroy
    destroyed = Participation.where(project: @project, user: current_user).destroy_all

    if destroyed.any?
      redirect_to @project, flash: { success: t('participation.left') }
    else
      redirect_to @project
    end
  end

  def leave
    destroyed = Participation.where(id: params['participation_id'], secret: params[:secret], project: @project).destroy_all

    if destroyed.any?
      redirect_to @project, flash: { success: t('participation.left') }
    else
      redirect_to @project
    end
  end

  private

  def find_project_friendly
    begin
      @project = Project.friendly.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, flash: { error: t('project.not_found') }
      return
    end

    unless @project.accessible_by?(current_user, params[:secret])
      redirect_to projects_path, status: :forbidden
    end
  end
end