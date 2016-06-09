class PagesController < ApplicationController

  def map
    selected = params[:select].to_i rescue nil
    @categories_data = categories_for_map
    @projects_data = projects_for_map(selected)
  end

end