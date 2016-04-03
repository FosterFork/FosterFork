class AbuseReportsController < ApplicationController
  before_action :find_project_friendly

  def new
    @page_title = t('abuse_report.report')
    @abuse_report = AbuseReport.new(project: @project)
  end

  def create
    if Settings.recaptcha and not user_signed_in? and not verify_recaptcha
      @abuse_report = AbuseReport.new(permitted_params)
      @abuse_report.project = @project
      return render :new
    end

    abuse_report = AbuseReport.new(permitted_params)
    abuse_report.reporter = current_user
    abuse_report.project = @project
    abuse_report.save!

    redirect_to @project, flash: { success: t('abuse_report.thank_you') }
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
    params[:abuse_report].permit([ :reason, :project_id ])
  end
end