module UrlOperator
  def self.valid_url?(url)
    uri = URI.parse(url)
    !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end
end