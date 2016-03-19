module ApplicationHelper

  def bootstrap_class_for flash_type
    {
      success: "alert-success",
      error: "alert-danger",
      recaptcha_error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }[flash_type.to_sym] || flash_type.to_s
  end

  def html_title
    t = Settings.application.name

    if @page_title
      t += " | #{@page_title}"
    end

    t
  end

  def link_to_markdown_overview_url
    link_to("Markdown", "https://guides.github.com/features/mastering-markdown/", target: '_new')
  end

  def selectable_countries
    Settings.application.allowed_countries&.map do |c|
      [ I18n.t(c.upcase.to_sym, scope: :countries), c ]
    end || []
  end

  def selectable_recurrence_types
    Project::RECURRENCE_TYPES.map do |t|
      [ I18n.t(t, scope: "recurrence_types"), t ]
    end
  end

  def code_revision
    revision = File.read(Rails.root.join("REVISION")) rescue nil
    return revision if revision

    revision = `git rev-parse --short HEAD`
    return revision if revision

    "unknown"
  end

end
