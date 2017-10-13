require 'rails_helper'

# TODO: test counters and rating updates callbacks (new, update-plus-minus-equal, destroy)
RSpec.describe Review, type: :model do
  context 'with simple creation' do
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
  end
end
