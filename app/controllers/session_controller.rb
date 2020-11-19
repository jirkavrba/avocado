class SessionController < ApplicationController
  def new
    redirect_to root_url if authenticated?
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    end

    redirect_back fallback_location: sign_in_url
  end
end
