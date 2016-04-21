class PagesController < ApplicationController

  def map
    projects = Project.publicly_visible
    selected = params[:select].to_i rescue nil
    @categories_data = Category.all.map do |category|
      {
        id: category.id,
        color: category.color,
      }
    end

    @projects_data = projects.map do |project|
      {
        x: CGI.escape(project.latitude.to_s),
        y: CGI.escape(project.longitude.to_s),
        cat_id: project.category.id,
        url: project_popup_content_url(project),
        open: selected == project.id
      }
    end
  end

end