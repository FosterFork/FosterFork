module LayoutHelper
require 'kramdown'

  def layout_render_markdown(input, caller_options = {})
    options = {
      auto_ids: false,
    }.merge(caller_options)

    doc = Kramdown::Document.new(input)
    doc.to_html
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

  def category_label(category)
    color = html_escape(category&.color || "black")
    name =  html_escape(category&.name || "")
    "<span class='label' style='background-color: #{color}'>#{name}</span>".html_safe
  end

end
