class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @review = @course.reviews.build
  end

  def create
    @review = @course.reviews.build(review_params)
    @review.user = current_user

    if @review.save!
      redirect_to @course, notice: 'Review created'
    else
      render :new, alert: 'No way! Fix some errors in your review.'
    end
  end

  def edit
  end

  def update
    if @review.update_attributes!(review_params)
      redirect_to @course, notice: 'Review updated'
    else
      render :edit, alert: 'No way! Fix some errors in your review.'
    end
  end

  def destroy
    @review.destroy!

    redirect_to @course, notice: 'Review deleted'
  end

  private

  def review_params
    params.require(:review).permit(:text, :rating)
  end

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
