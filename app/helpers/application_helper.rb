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
    t = Settings.platform_name

    if @page_title
      t += " | #{@page_title}"
    end

    t
  end

  def link_to_markdown_overview_url
    link_to("Markdown", "https://guides.github.com/features/mastering-markdown/", target: '_new')
  end

  def code_revision
    revision = File.read(Rails.root.join("REVISION")) rescue nil
    return revision if revision

    revision = `git rev-parse --short HEAD`
    return revision if revision

    "unknown"
  end

  def projects_for_map(selected = nil)
    Project.publicly_visible.where.not(latitude: nil).map do |project|
      {
        x:      ERB::Util.html_escape(project.latitude.to_s),
        y:      ERB::Util.html_escape(project.longitude.to_s),
        cat_id: ERB::Util.html_escape(project.category.id),
        url: project_popup_content_url(project),
        open: selected == project.id
      }
    end
  end

  def categories_for_map
    cs = Category.all.select do |c|
      c.projects.any?
    end

    cs.map do |category|
      {
        id: category.id,
        color: category.color,
      }
    end
  end

  def selectable_countries
    Settings.countries&.map do |c|
      [ I18n.t(c.upcase.to_sym, scope: :countries), c ]
    end || []
  end

  def selectable_recurrence_types
    Project::RECURRENCE_TYPES.map do |t|
      [ I18n.t(t, scope: "recurrence_types"), t ]
    end
  end

  def selectable_locales
    Settings.locales.to_hash.invert
  end

  def selectable_categories
    Category.all&.map do |c|
      [ c.translated_name, c.id ]
    end
  end

  def selectable_proximities
    a = []
    a << [ I18n.t("disabled"), 0 ]
    [ 2, 5, 10, 20, 100, 200, 500 ].each do |i|
      a << [ "#{i} km", i ]
    end
    a
  end

end
