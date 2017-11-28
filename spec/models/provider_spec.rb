require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe '.create' do
    # domain main checks
    it { should_not allow_value('/lsl-sdf-sfdf/').for(:domain) }
    it { should_not allow_value('/udemy.com/').for(:domain) }
    it { should_not allow_value('ht:coursera.org').for(:domain) }
    it { should_not allow_value('http:edx.com').for(:domain) }
    it { should_not allow_value('edx.com/#super-courrse-mega').for(:domain) }
    it { should_not allow_value('www.udemy.com/?q=1').for(:domain) }
    it { should_not allow_value('udemy.com//?q=1').for(:domain) }
    it { should_not allow_value('http://coursera.org').for(:domain) }
    it { should_not allow_value('https://edx.com').for(:domain) }
    it { should allow_value('udemy.com').for(:domain) }
    it { should allow_value('COURSERA.org').for(:domain) }

    it { should have_many(:courses).dependent(:restrict_with_exception) }

    it 'downcases domain' do
      provider = FactoryBot.create(:provider, domain: 'EdX.oRg')
      expect(provider.domain).to eq 'edx.org'
    end
  end
end
