require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    # URL main checks
    it { should_not allow_value('/lsl-sdf-sfdf/').for(:url) }
    it { should_not allow_value('/udemy.com/').for(:url) }
    it { should_not allow_value('ht:coursera.org').for(:url) }
    it { should_not allow_value('http:edx.com').for(:url) }
    it { should allow_value('edx.com/#super-courrse-mega').for(:url) }
    it { should allow_value('www.udemy.com/?q=1').for(:url) }
    it { should allow_value('udemy.com//?q=1').for(:url) }
    it { should allow_value('udemy.com/mega-reference-').for(:url) }
    it { should allow_value('coursera.org').for(:url) }
    it { should allow_value('http://coursera.org').for(:url) }
    it { should allow_value('https://edx.com').for(:url) }

    it { should belong_to(:provider) }
  end

  describe '.create' do
    let(:c) { Course.create(url: 'http://www.UDEMY.com/mega-course/', title: 'MegaC', description: '', creator: FactoryBot.create(:user)) }
    it 'creates new provider' do
      expect {
        expect(c.provider.domain).to eq 'udemy.com'
        expect(c.provider.title).to eq 'Udemy.com'
      }.to change(Provider, :count).by(1)
    end

    it 'links existing provider' do
      p = FactoryBot.create(:provider, domain: 'udemy.com')
      expect {
        expect(c.provider).to eq p
      }.not_to change(Provider, :count)
    end

    it 'doesnt create provider if specified' do
      p = FactoryBot.create(:provider, domain: 'edx.org')
      expect {
        c = Course.create!(url: 'http://www.UDEMY.com/mega-course/',
                           title: 'MegaC', description: '',
                           provider: p, creator: FactoryBot.create(:user))
        expect(c.provider).to eq p
      }.not_to change(Provider, :count)
    end

    it 'is not saved without provider' do
      expect {
        c = Course.create(url: 'http://wwwUDEMYcom/mega-course/', title: 'MegaC',
                          description: '', creator: FactoryBot.create(:user))
        expect(c).not_to be_valid
        expect(c).not_to be_persisted
      }.not_to change(Provider, :count)
    end
  end

  describe '#upload_avatar' do
    let(:course) { FactoryBot.create(:course) }
    it 'stores right file in righ path' do
      course.picture = Rails.root.join('spec/fixtures/avatar.JPEG').open
      course.save!

      c1 = Course.last
      expect(c1.picture.file).to exist
      expect(c1.picture.content_type).to eq 'image/jpeg'
      expect(c1.picture.url).to match(/\/system\/course\/picture\/\d{3}\/a6c1253929f88698fa3e0664d96885d7\.jpg/)
      expect(c1.picture.small.url).to match(/\/system\/course\/picture\/\d{3}\/small_a6c1253929f88698fa3e0664d96885d7\.jpg/)
      expect(c1.picture.current_path).to match(/\/public\/system\/course\/picture\/\d{3}\/a6c1253929f88698fa3e0664d96885d7\.jpg/)

      expect(File.size(c1.picture.current_path)).to be > File.size(c1.picture.small.current_path)
    end

    it 'doesnt allow not pics' do
      course.picture = Rails.root.join('spec/fixtures/sample.txt').open
      expect(course.save).to be_falsey
      expect(course.errors[:picture]).to be
    end

    it 'doesnt allow files > 1MB' do
      course.picture = Rails.root.join('spec/fixtures/1_2mb.jpg').open
      expect(course.save).to be_falsey
      expect(course.errors[:picture]).to be
    end
  end
end
