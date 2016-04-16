class TextBlocksController < ApplicationController
  include LayoutHelper

  respond_to :html

  # ruby ftw - render textblock with passed name
  def action_missing(action)
    render_textblock(action)
  end

  def show
    render_textblock(params[:id])
  end

  private

  def render_textblock(name)
    block = TextBlock.block_for(name.to_s)

    @page_title = @title = block.title
    @content = layout_render_textblock(block)

    render :article
  end

end
