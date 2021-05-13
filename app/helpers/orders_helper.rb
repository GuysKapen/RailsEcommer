# frozen_string_literal: true

module OrdersHelper
  def country_name(country_code)
    country = ISO3166::Country[country_code]
    return if country.nil?

    country.translations[I18n.locale.to_s] || country.name
  end
end
