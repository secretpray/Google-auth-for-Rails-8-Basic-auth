class OauthCallbacksController < ApplicationController
  skip_before_action :require_authentication, :verify_authenticity_token

  def omniauth_callback
    @user = User.find_or_create_from_auth(auth_hash)

    if @user.persisted?
      start_new_session_for(@user)
      redirect_to root_path, notice: "Signed in successfully with #{provide_name}."
    else
      redirect_to sign_in_path, alert: "Failed to authenticate with #{provide_named}."
    end
  end

  def failure
    redirect_to sign_in_path, alert: "Authentication failed: #{params[:message]}"
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def provide_name
    @provide_name ||= auth_hash.provider.humanize
  end
end
