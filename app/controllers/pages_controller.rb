class PagesController < ApplicationController

  def map
    projects = Project.publicly_visible
    selected = params[:select].to_i rescue nil
    @map_data = projects.map do |project|
      {
        x: CGI.escape(project.latitude.to_s),
        y: CGI.escape(project.longitude.to_s),
        url: project_popup_content_url(project),
        open: selected == project.id
      }
    end
  end

end