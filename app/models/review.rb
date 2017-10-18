class Review < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :user

  validates :text, presence: {if: -> {rating.blank?}}
  validates :rating, presence: {if: -> {text.blank?}}
  validates :html, presence: {if: -> {text.present?}}
  validates :rating, inclusion: 1..5, allow_nil: true

  validates :user_id, uniqueness: {scope: [:course_id]}

  after_save :update_course_rating
  after_destroy :remove_course_rating

  before_validation :generate_html

  scope :with_rating, -> {where.not(rating: nil)}
  scope :with_text, -> {where.not(text: nil)}

  private

  def update_course_rating
    new_r = rating
    old_r = rating_before_last_save
    course.update_avg_rating(old_r, new_r) if saved_change_to_rating? && new_r != old_r
  end

  def remove_course_rating
    course.update_avg_rating(rating, nil)
  end

  def generate_html
    self.html = CommonMarker.render_html(text.to_s, [:SAFE,:NOBREAKS, :GITHUB_PRE_LANG], [:autolink])
  end
end
