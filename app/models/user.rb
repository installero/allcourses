class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :reviews, dependent: :restrict_with_exception
  has_many :courses, dependent: :restrict_with_exception

  has_many :oauth_identities

  mount_uploader :avatar, AvatarUploader

  def name
    "#{first_name} #{last_name.first}."
  end

  def uses_oauth?
    oauth_identities.any?
  end
end
