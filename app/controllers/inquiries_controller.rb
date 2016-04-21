class InquiriesController < ApplicationController
  before_action :find_project_friendly
  before_action :authenticate_user!

  def new
    @page_title = t('inquiry.report')
    @inquiry = Inquiry.new(project: @project)
  end

  def create
    inquiry = Inquiry.new(permitted_params)
    inquiry.user = current_user
    inquiry.project = @project
    inquiry.save!

    redirect_to @project, flash: { success: t('inquiry.thank_you') }
  end

  private

  def find_project_friendly
    begin
      @project = Project.friendly.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, flash: { error: t('project.not_found') }
    end
  end

  def permitted_params
    params[:inquiry].permit([ :content, :project_id ])
  end
end