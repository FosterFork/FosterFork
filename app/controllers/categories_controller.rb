class CategoriesController < ApplicationController

  def show
    begin
      @category = Category.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path
      return
    end

    projects = @category.projects.publicly_visible
    @projects = projects.paginate(page: params[:page])
  end

end
