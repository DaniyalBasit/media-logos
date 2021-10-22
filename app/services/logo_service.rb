require "addressable/uri"

class LogoService
  include HTTParty

  BASE_URL = 'https://logo.clearbit.com/'
  DOMAIN_REGEX = /^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9]))\.([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}\.[a-zA-Z]{2,3})$/

  class << self
    def get_logos(params = {})
      return {} unless params[:urls].present?

      images_hash = ActiveSupport::HashWithIndifferentAccess.new
      urls = params[:urls].delete_if(&:blank?)

      urls.each do |url_|
        domain = Addressable::URI.parse(url_).domain
        domain = url_ if !domain.present? && (url_ =~ DOMAIN_REGEX) == 0
        images_hash.store(domain.to_s, { site_url: url_, img_src: "#{BASE_URL}#{domain}?size=80" }) if domain.present?
      end

      images_hash
    end
  end
end
