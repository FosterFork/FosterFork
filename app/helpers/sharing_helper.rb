module SharingHelper

  def sharing_link_to(provider, settings, project)
    case provider
    when :facebook
      params = {
        u: project_url(project),
      }.merge(settings || {})

      link_to "https://www.facebook.com/sharer/sharer.php?#{params.to_query}", target: '_blank' do yield; end;

    when :twitter
      params = {
        url: project_url(project),
        text: I18n.t('sharing.twitter.tweet_text', project: project.title, platform_name: Settings.platform_name)
      }.merge(settings || {})

      link_to "https://twitter.com/intent/tweet?#{params.to_query}", target: '_blank' do yield; end;

    when :google_plus
      params = {
        url: project_url(project)
      }.merge(settings || {})

      link_to "https://plus.google.com/share?#{params.to_query}", target: '_blank' do yield; end;

    when :xing
      params = {
        url: project_url(project),
        op: "share",
        sc_p: "xing-share"
      }.merge(settings || {})

      link_to "https://www.xing-share.com/app/user?#{params.to_query}", target: '_blank' do yield; end;

    when :linkedin
      params = {
        url: project_url(project),
        source: project_url(project),
        title: project.title,
        summary: I18n.t('sharing.linkedin.share_text', project: project.title, platform_name: Settings.platform_name),
        mini: "true",
      }.merge(settings || {})

      link_to "https://www.linkedin.com/shareArticle?#{params.to_query}", target: '_blank' do yield; end;

    when :email
      params = {
        subject: I18n.t('sharing.email.subject', project: project.title, platform_name: Settings.platform_name),
        body: I18n.t('sharing.email.body', project: project.title, url: project_url(project), platform_name: Settings.platform_name),
      }.merge(settings || {})

      mail_to "", body: params[:body], subject: params[:subject] do yield; end;
    else
      raise "Unknown sharing provider '#{provider.to_s}'"
    end
  end

  def sharing_icon_for(provider)
    case provider
    when :google_plus
      "fa-google-plus-square"
    when :email
      "fa-envelope-square"
    else
      "fa-#{provider.to_s}-square"
    end
  end

end