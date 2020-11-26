class ApplicationController < ActionController::Base
  include AuthenticationHelper

  breadcrumb "Dashboard", :dashboard_path

  def forbidden
    render 'errors/403', status: :forbidden
  end
end
