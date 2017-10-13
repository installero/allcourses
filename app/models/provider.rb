class Provider < ApplicationRecord
  has_many :courses, dependent: :restrict_with_exception

  # https://github.com/ruby/ruby/blob/trunk/lib/uri/rfc2396_parser.rb#L21-L56
  DOMAIN_REGEXP = /\A#{URI::RFC2396_REGEXP::PATTERN::HOSTNAME}\Z/

  validates :title, presence: true
  validates :domain, format: {with: DOMAIN_REGEXP}, presence: true, uniqueness: true

  before_validation {self.domain = domain.downcase if domain}
  before_validation {self.title = domain.capitalize if title.blank? && domain.present?}
end
