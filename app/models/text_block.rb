class TextBlock < ActiveRecord::Base

  validates_presence_of :name
  validates :name, format: { :with => /\A[a-z0-9_\-]+\z/ }

  def self.block_for(name, locale = I18n.locale)
    r = TextBlock.where(name: name, public: true, locale: [ locale, nil, '' ])
                 .order("updated_at DESC").first
    return r if r

    # Provide a dummy TextBlock if the lookup failed, so we can rely on
    # getting something useful back from this method.

    TextBlock.new({ name: name,
                    locale: locale,
                    public: true,
                    title: "Dummy title for text block '#{name}'",
                    body: "Dummy body for text block '#{name}'." })
  end
end
