class PagesController < ApplicationController

  def root
    @welcome_textblock = TextBlock.block_for("welcome")
    @categories_data = categories_for_map
    @projects_data = projects_for_map
  end

  def map
    selected = params[:select].to_i rescue nil
    @categories = Category.all
    @categories_data = categories_for_map
    @projects_data = projects_for_map(selected)
  end

end