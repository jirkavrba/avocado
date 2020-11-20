class SessionController < ApplicationController
  def new
    redirect_to dashboard_path if authenticated?
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      sign_in user
      return redirect_to dashboard_path
    end

    redirect_back fallback_location: sign_in_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
