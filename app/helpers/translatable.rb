module Translatable
  def translated_name(locale = I18n.locale)
    t = translations.where(locale: locale).first
    t.title rescue name
  end
end
