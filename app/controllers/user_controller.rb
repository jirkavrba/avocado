class UserController < ApplicationController
  def new
    redirect_to dashboard_url if authenticated?
    @user = User.new
  end

  def create
    user =  User.create(user_params)

    if user.valid?
      sign_in user
      redirect_to dashboard_url
    else
      flash[:alert] = user.errors.full_messages.first
      redirect_to sign_up_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
