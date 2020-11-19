class SessionController < ApplicationController
  def new
    redirect_to root_url if authenticated?
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      sign_in user
      return redirect_to dashboard_url
    end

    redirect_back fallback_location: sign_in_url
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
