class PagesController < ApplicationController

  def root
    @welcome_textblock = TextBlock.block_for("welcome")
    @images = LayoutImage.where(page: 'root', locale: [ I18n.locale, nil ])
    @categories_data = categories_for_map
    @projects_data = projects_for_map
  end

  def map
    selected = params[:select].to_i rescue nil
    @categories_data = categories_for_map
    @projects_data = projects_for_map(selected)
  end

end