class TagsController < ApplicationController

  def show
    begin
      @tag = Tag.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path
      return
    end

    projects = @tag.projects.publicly_visible
    @projects = projects.paginate(page: params[:page])
  end

end
