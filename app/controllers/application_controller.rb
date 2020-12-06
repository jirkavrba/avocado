# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthenticationHelper

  rescue_from CanCan::AccessDenied, with: :forbidden

  protected

  def forbidden
    render 'errors/403', status: :forbidden
  end

  def not_found
    render 'errors/404', status: :not_found
  end
end
