module AuthenticationHelper
  def current_user
    # noinspection RailsChecklist05
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticated?
    !current_user.nil?
  end

  def authenticate!
    redirect_to root_url unless authenticated?
  end
end