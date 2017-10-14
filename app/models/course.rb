class Course < ApplicationRecord
  include UrlValidator

  belongs_to :provider

  has_many :reviews, dependent: :destroy

  # http://api.rubyonrails.org/v5.1/classes/ActiveRecord/Enum.html
  # Mostly based on Udemy classification:
  # Programming
  # IT & Computers
  # Business
  # Personal development
  # Languages
  # Design
  # Marketing
  # Academics
  # Hobby & lifestyle
  # Health & Fitness
  # Other
  enum genre: {other: 0,
               programming: 1,
               itcomp: 2,
               business: 3,
               personal: 4,
               lang: 5,
               design: 6,
               marketing: 7,
               academics: 8,
               hobby: 9,
               health: 10}

  validates :title, presence: true
  validates :genre, presence: true, numericality: true
  validates :description, presence: true, allow_blank: true
  validates :rating, numericality: {greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0}, allow_nil: true

  validates :url, presence: true, uniqueness: true
  validate :url_allowed #UrlOperator

  before_validation :create_provider, unless: :provider

  def update_avg_rating(old_stars, new_stars)
    Course.increment_counter(:ratings_count, id) if old_stars.nil?
    Course.decrement_counter(:ratings_count, id) if new_stars.nil?

    self.rating = reviews.average(:rating).to_f.round(1)
    save
  end

  private

  def create_provider
    # url at this point must be clean and good
    domain = PublicSuffix.domain(host(url), ignore_private: true)
    p = Provider.find_or_create_by(domain: domain)
    self.provider = p if p.valid?
  end
end