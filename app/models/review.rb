class Review < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :user

  validates :text, presence: {if: -> {rating.blank?}}
  validates :rating, presence: {if: -> {text.blank?}}
  validates :rating, inclusion: 1..5, allow_nil: true

  validates :user_id, uniqueness: {scope: [:course_id]}

  after_save :update_course_rating
  after_destroy :remove_course_rating

  private

  def update_course_rating
    new_r = rating
    old_r = rating_before_last_save
    course.update_avg_rating(old_r, new_r) if saved_change_to_rating? && new_r != old_r
  end

  def remove_course_rating
    course.remove_rating(rating)
  end
end
