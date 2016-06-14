class ProjectsController < ApplicationController
  before_action :find_project_friendly, only: [ :show, :edit, :update, :destroy, :popup_content, :new_secret ]
  before_action :authenticate_user!,    only: [ :create, :new ]
  before_action :authenticate_owner!,   only: [ :edit, :update, :destroy, :new_secret ]

  def index
    @page_title = t('nav.projects')
    @q = params[:q] unless params[:q].nil? or params[:q].empty?

    unless @q or (params[:page] and params[:page].to_i > 1)
      @welcome_textblock = TextBlock.block_for("welcome")
    end

    if (@q)
      projects = Project.publicly_visible
                              .includes(:participations, :owner, :category, :messages, category: [ :translations ])
                              .ransack(title_cont: @q,
                                       description_cont: @q,
                                       public: true,
                                       m: 'or',
                                       sort: 'date')
                              .result(distinct: true)
    else
      projects = Project.publicly_visible
                              .includes(:participations, :owner, :messages, category: [ :translations ])
                              .order(:date)
    end

    @projects = projects.paginate(page: params[:page], per_page: 20)
    @categories_data = categories_for_map
    @projects_data = projects_for_map
  end

  def new
    @page_title = t('project.add')
    @project = Project.new
    @project.date = Time.now
    @project.inquiries_allowed = true
  end

  def create
    @project = Project.new(permitted_params)
    @project.owner = current_user
    @project.active = true
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def show
    @page_title = @project.title
    @current_user_participation = current_user&.participation_in(@project)
    @sharing_options = Settings.sharing[I18n.locale] || [] rescue []

    respond_to do |format|
      format.html do
        flash.now[:error] = t('project.awaiting_approval') unless @project.approved
      end

      format.ics do
        filename = "#{@project.id}-#{@project.slug}.ics"
        send_data(@project.to_ics, filename: filename, disposition: "inline; filename=#{filename}", type: "text/calendar")
      end

      format.atom
    end
  end

  def edit
    @page_title = t('project.edit')
  end

  def update
    if @project.update(permitted_params.except(:title, :category_id))
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path, flash: { success: t('project.deleted') }
  end

  def popup_content
    render :popup_content, layout: nil
  end

  def new_secret
    @project.generate_secret!
    @project.save
    redirect_to edit_project_path(@project), flash: { success: t('project.new_secret_generated') }
  end

  private

  def find_project_friendly
    begin
      @project = Project.with_associations.friendly.find(params[:id] || params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, flash: { error: t('project.not_found') }
      return
    end

    unless @project.accessible_by?(current_user, params[:secret])
      redirect_to projects_path, status: :forbidden
    end
  end

  def authenticate_owner!
    redirect_to projects_path, status: :forbidden unless @project.owner == current_user
  end

  def permitted_params
    params[:project].permit([ :title, :category_id, :abstract, :description, :date, :recurrence,
                              :address, :zip, :city, :country, :public, :active,
                              :inquiries_allowed ])
  end

end