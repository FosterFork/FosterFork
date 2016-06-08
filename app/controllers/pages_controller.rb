class PagesController < ApplicationController

  def map
    projects = Project.publicly_visible.where.not(latitude: nil)
    selected = params[:select].to_i rescue nil
    @categories_data = Category.all.map do |category|
      {
        id: category.id,
        color: category.color,
      }
    end

    @projects_data = projects.map do |project|
      {
        x:      ERB::Util.html_escape(project.latitude.to_s),
        y:      ERB::Util.html_escape(project.longitude.to_s),
        cat_id: ERB::Util.html_escape(project.category.id),
        url: project_popup_content_url(project),
        open: selected == project.id
      }
    end
  end

end