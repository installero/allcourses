class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews, dependent: :restrict_with_exception
  has_many :courses, dependent: :restrict_with_exception

  def name
    "#{first_name} #{last_name.first}."
  end
end
