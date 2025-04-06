class OauthCallbacksController < ApplicationController
  skip_before_action :require_authentication, only: %i[google failure google_auth]

  def google
    @user = User.find_or_create_from_google_auth(auth_hash)

    if @user.persisted?
      start_new_session_for(@user)
      redirect_to root_path, notice: "Signed in successfully with Google."
    else
      redirect_to sign_in_path, alert: "Failed to authenticate with Google."
    end
  end

  def failure
    redirect_to sign_in_path, alert: "Authentication failed: #{params[:message]}"
  end

  def google_auth
    redirect_to "/auth/google_oauth2"
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
