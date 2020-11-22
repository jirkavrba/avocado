class ApplicationController < ActionController::Base
  include AuthenticationHelper

  def forbidden
    render 'errors/403', status: :forbidden
  end
end
