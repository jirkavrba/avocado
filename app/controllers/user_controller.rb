class UserController < ApplicationController

  before_action :can_modify?, except: %i[new create]

  def new
    redirect_to dashboard_url if authenticated?
    @user = User.new
  end

  def create
    sign_in User.create!(user_params)
    redirect_to dashboard_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def can_modify?
    authenticated? && (current_user.is_admin? || current_user.id == params[:id])
  end
end
