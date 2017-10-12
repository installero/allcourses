class Provider < ApplicationRecord
  include UrlValidator

  has_many :courses, dependent: :restrict_with_exception

  validates :title, presence: true

  validates :url, presence: true, uniqueness: true
  validate :url_allowed #UrlValidator
end
