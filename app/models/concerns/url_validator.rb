module UrlValidator
  # idea from http://stackoverflow.com/a/7167988
  # Just a prototype, need to be improved in many ways.
  def url_allowed
    unless valid_url?(url)
      http_url = "http://#{url}"

      if valid_url?(http_url)
        self.url = http_url
      else
        errors.add(:url, :invalid)
      end
    end
  end

  def valid_url?(url)
    uri = URI.parse(url)
    !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def host(url)
    URI.parse(url).host
  end
end