class InquiriesController < ApplicationController
  before_action :find_project_friendly
  before_action :check_inquiries_allowed
  before_action :authenticate_user!

  def new
    @page_title = t('inquiry.send')
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

  def check_inquiries_allowed
    redirect_to @project unless @project.inquiries_allowed
  end

  def permitted_params
    params[:inquiry].permit([ :content, :project_id ])
  end
end