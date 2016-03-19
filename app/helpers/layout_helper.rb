module LayoutHelper

  def layout_render_markdown(input, caller_options = {})
    options = {
                filter_html: true,
                safe_links_only: true,
                no_styles: true,
                hard_wrap: true,
                no_intraemphasis: true,
              }.merge(caller_options)

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(input)
  end

  def layout_render_textblock(block)
    begin
      content = layout_render_markdown(block.body)
    rescue Exception => msg
      content = "<b>ERROR rendering TextBlock with id #{block.id} (#{block.title})</b>"
      content += "<p>#{ERB::Util.html_escape(msg.to_s)}</p>"
    end
    content.html_safe
  end

end
