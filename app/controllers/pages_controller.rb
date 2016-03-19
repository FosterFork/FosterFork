class PagesController < ApplicationController

  def map
    projects = Project.where(public: true)
    selected = params[:select].to_i rescue nil
    @map_data = projects.map do |i|
      {
        x: CGI.escape(i.latitude.to_s),
        y: CGI.escape(i.longitude.to_s),
        url: project_popup_content_url(i, id: i.id),
        open: selected == i.id
      }
    end
  end

end