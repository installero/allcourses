require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'rating_stars_for' do
    it 'renders 5 full stars' do
      rendered = helper.rating_stars_for(5)

      expect(rendered).to have_css '.fa-star', count: 5
    end

    it 'renders 4 full stars + 1 empty star' do
      rendered = helper.rating_stars_for(3.9)

      expect(rendered).to have_css '.fa-star', count: 4
      expect(rendered).to have_css '.fa-star-o', count: 1
    end

    it 'renders 3 full stars + 1 half star + 1 empty star' do
      rendered = helper.rating_stars_for(3.3)

      expect(rendered).to have_css '.fa-star', count: 3
      expect(rendered).to have_css '.fa-star-half-o', count: 1
      expect(rendered).to have_css '.fa-star-o', count: 1
    end
  end
end
