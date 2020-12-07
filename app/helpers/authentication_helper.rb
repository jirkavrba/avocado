module AuthenticationHelper
  def current_user
    # noinspection RailsChecklist05
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def authenticated?
    !current_user.nil?
  end

  def authenticate!
    redirect_to sign_in_path unless authenticated?
  end
end