class OauthIdentity < ApplicationRecord
  belongs_to :user

  def self.from_facebook_omniauth(auth_token)
    uid = auth_token.uid

    self.first_or_create!(provider: 'facebook', uid: uid) do |identity|
      email = auth_token.info.email

      user = User.first_or_create!(email: email) do |user|
        user.first_name, user.last_name = auth_token.info.name.split
        user.password = Devise.friendly_token[0,20]
        user.confirm
      end

      identity.user = user
    end
  end
end
