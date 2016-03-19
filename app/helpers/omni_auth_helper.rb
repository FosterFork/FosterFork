module OmniAuthHelper

  def available_omniauth_providers
    p = {}

    return p unless Settings.oauth

    if Settings.oauth.facebook
      p[:facebook] = { provider: :facebook,
                       pretty_name: "Facebook",
                       fa_icon: "facebook-square",
                       id:  Settings.oauth.facebook.app_id,
                       key: Settings.oauth.facebook.app_secret }
    end

    if Settings.oauth.twitter
      p[:twitter] = { provider: :twitter,
                      pretty_name: "Twitter",
                      fa_icon: "twitter-square",
                      id:  Settings.oauth.twitter.api_key,
                      key: Settings.oauth.twitter.api_secret }
    end

    if Settings.oauth.linkedin
      p[:linkedin] = { provider: :linkedin,
                       pretty_name: "LinkedIn",
                       fa_icon: "linkedin-square",
                       id:  Settings.oauth.linkedin.client_id,
                       key: Settings.oauth.linkedin.client_secret }
    end

    if Settings.oauth.google
      p[:google]   = { provider: :google_oauth2,
                       pretty_name: "Google",
                       fa_icon: "google",
                       id:  Settings.oauth.google.client_id,
                       key: Settings.oauth.google.client_key }
    end

    if Settings.oauth.github
      p[:github]   = { provider: :github,
                       pretty_name: "GitHub",
                       fa_icon: "github-square",
                       id:  Settings.oauth.github.client_id,
                       key: Settings.oauth.github.client_secret }
    end

    p
  end

  def get_omniauth_setting_for(provider, key)
    begin
      h = available_omniauth_providers.values.select { |p| p[:provider] == provider.to_sym }[0]
      h[key] rescue nil
    rescue
      {}
    end
  end

end