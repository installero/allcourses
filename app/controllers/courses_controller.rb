class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
    @current_user_review = @course.reviews.find_by(user: current_user)
  end

  def new
    @course = Course.new
    @course.genre = nil
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.creator = current_user

    if verify_recaptcha(model: @course) && @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    if verify_recaptcha(model: @course) && @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def authorize_user!
    reject_user unless current_user_can_edit?(@course)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(
      :url,
      :title,
      :description,
      :genre
    )
  end
end
