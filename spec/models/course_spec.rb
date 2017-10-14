require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    # URL main checks
    it {should_not allow_value('/lsl-sdf-sfdf/').for(:url)}
    it {should_not allow_value('/udemy.com/').for(:url)}
    it {should_not allow_value('ht:coursera.org').for(:url)}
    it {should_not allow_value('http:edx.com').for(:url)}
    it {should allow_value('edx.com/#super-courrse-mega').for(:url)}
    it {should allow_value('www.udemy.com/?q=1').for(:url)}
    it {should allow_value('udemy.com//?q=1').for(:url)}
    it {should allow_value('udemy.com/mega-reference-').for(:url)}
    it {should allow_value('coursera.org').for(:url)}
    it {should allow_value('http://coursera.org').for(:url)}
    it {should allow_value('https://edx.com').for(:url)}

    it {should belong_to(:provider)}
  end

  describe '.create' do
    it 'creates new provider' do
      expect {
        c = Course.create(url: 'http://www.UDEMY.com/mega-course/', title: 'MegaC', description: '')
        expect(c.provider.domain).to eq 'udemy.com'
        expect(c.provider.title).to eq 'Udemy.com'
      }.to change(Provider, :count).by(1)
    end

    it 'links existing provider' do
      p = FactoryGirl.create(:provider, domain: 'udemy.com')
      expect {
        c = Course.create(url: 'http://www.UDEMY.com/mega-course/', title: 'MegaC', description: '')
        expect(c.provider).to eq p
      }.not_to change(Provider, :count)
    end

    it 'doesnt create provider if specified' do
      p = FactoryGirl.create(:provider, domain: 'edx.org')
      expect {
        c = Course.create!(url: 'http://www.UDEMY.com/mega-course/', title: 'MegaC', description: '', provider: p)
        expect(c.provider).to eq p
      }.not_to change(Provider, :count)
    end

    it 'is not saved without provider' do
      expect {
        c = Course.create(url: 'http://wwwUDEMYcom/mega-course/', title: 'MegaC', description: '')
        expect(c).not_to be_valid
        expect(c).not_to be_persisted
      }.not_to change(Provider, :count)
    end
  end
end
