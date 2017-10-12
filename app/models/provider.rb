class Provider < ApplicationRecord
  has_many :courses, dependent: :restrict_with_exception

  validates :title, presence: true

  validates :url, presence: true, uniqueness: true
  validate :url_allowed



  private
  # idea from http://stackoverflow.com/a/7167988
  # Just a prototype, need to be improved in many ways.
  def url_allowed
    unless UrlOperator.valid_url?(url)
      http_url = "http://#{url}"

      if UrlOperator.valid_url?(http_url)
        self.url = http_url
      else
        errors.add(:url, :invalid)
      end
    end
  end
end
