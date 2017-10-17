require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:course) {FactoryGirl.create(:course)}

  describe '.update_course_rating' do
    context 'with new review' do
      it 'increases reviews_count' do
        expect {
          course.reviews.create(text: 'blabla', user: user)
        }.to change(course, :reviews_count).by(1).and change(course, :ratings_count).by(0)
      end

      it 'increases ratings_count' do
        expect {
          course.reviews.create(rating: 1, user: user)
          course.reload
        }.to change(course, :reviews_count).by(1).and change(course, :ratings_count).by(1)
      end

      it 'sets new rating' do
        expect(course.rating).to eq 0
        course.reviews.create(rating: 3, user: user)
        expect(course.rating).to eq 3
      end

      it 'updates rating' do
        expect(course.rating).to eq 0
        course.reviews.create(rating: 3, user: user)
        course.reviews.create(rating: 4, user: FactoryGirl.create(:user))
        expect(course.rating).to eq 3.5
        course.reviews.create!(rating: nil, text: 'okay', user: FactoryGirl.create(:user))
        expect(course.reload.rating).to eq 3.5
      end
    end

    context 'with existing review' do
      let!(:review) {FactoryGirl.create(:review, rating: nil, course: course)}
      let!(:review2) {FactoryGirl.create(:review, rating: 3, course: course)}

      it 'adds stars' do
        course.reload
        expect(course.rating).to eq 3
        expect(course.ratings_count).to eq 1
        expect(course.reviews_count).to eq 2
        review.update_attributes(rating: 4)
        course.reload
        expect(course.rating).to eq 3.5
        expect(course.ratings_count).to eq 2
        expect(course.reviews_count).to eq 2
      end

      it 'removes stars' do
        review.update_attributes(rating: 4)
        review.update_attributes(rating: nil)
        course.reload
        expect(course.rating).to eq 3
        expect(course.ratings_count).to eq 1
        expect(course.reviews_count).to eq 2
        review2.update_attributes(rating: nil)
        course.reload
        expect(course.rating).to eq 0
        expect(course.ratings_count).to eq 0
        expect(course.reviews_count).to eq 2
      end

      it 'increase stars' do
        review.update_attributes(rating: 3)
        review.update_attributes(rating: 5)
        course.reload
        expect(course.rating).to eq 4.0
        expect(course.ratings_count).to eq 2
        expect(course.reviews_count).to eq 2
      end

      it 'decrease stars' do
        review.update_attributes(rating: 4)
        review2.update_attributes(rating: 1)
        course.reload
        expect(course.rating).to eq 2.5
        expect(course.ratings_count).to eq 2
        expect(course.reviews_count).to eq 2
      end

      it 'drops rating on nil review destroy' do
        review.destroy!
        course.reload
        expect(course.rating).to eq 3
        expect(course.ratings_count).to eq 1
        expect(course.reviews_count).to eq 1
      end

      it 'drops rating on stars review destroy' do
        review.update_attributes(rating: 4)
        review2.destroy!
        course.reload
        expect(course.rating).to eq 4
        expect(course.ratings_count).to eq 1
        expect(course.reviews_count).to eq 1
      end
    end
  end

  describe '.create' do
    subject {FactoryGirl.build(:review)}

    it {should_not allow_value(0).for(:rating)}
    it {should_not allow_value(6).for(:rating)}
    it {should allow_value(nil).for(:rating)}
    it {should allow_value(1).for(:rating)}

    it {should validate_uniqueness_of(:user_id).scoped_to(:course_id)}

    it 'allows nil text if rating present' do
      r = FactoryGirl.create(:review, rating: 5, text: nil)
      expect(r).to be_valid
      expect(r.rating).to eq 5
      expect(r.text).not_to be
    end

    it 'allows nil rating if text present' do
      r = FactoryGirl.create(:review, rating: nil)
      expect(r).to be_valid
      expect(r.rating).to be_nil
      expect(r.text).to be
    end

    it 'doesnt allow nil text&rating' do
      r = FactoryGirl.build(:review, rating: nil, text: nil)
      expect(r).not_to be_valid
      expect(r.rating).to be_nil
      expect(r.text).to be_nil
    end

    it 'renders HTML' do
      course.reviews.create(
        text: "http://ya.ru \nhey na \n\nney\n ``` ruby\n i = ;\n```\nМир' вам",
        user: user)
      expect(course.reviews.last.html).to eq "<p><a href=\"http://ya.ru\">http://ya.ru</a> hey na</p>\n<p>ney</p>\n<pre lang=\"ruby\"><code>i = ;\n</code></pre>\n<p>Мир' вам</p>\n"
    end
  end
end
