class ApplicationController < ActionController::Base
  include AuthenticationHelper

  def forbidden
    render text: 'Forbidden',
           status: :forbidden
  end
end
