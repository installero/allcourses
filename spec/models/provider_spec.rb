require 'rails_helper'

RSpec.describe Provider, type: :model do
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

  it {should have_many(:courses).dependent(:restrict_with_exception)}
end
