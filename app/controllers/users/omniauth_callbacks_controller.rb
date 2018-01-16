class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @oauth_identity = OauthIdentity.from_facebook_omniauth(request.env["omniauth.auth"])

    if @oauth_identity.persisted?
      sign_in_and_redirect @oauth_identity.user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook")
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
