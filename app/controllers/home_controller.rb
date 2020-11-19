class HomeController < ApplicationController
  before_action :authenticate!, except: [:index]

  def index
    redirect_to dashboard_path if authenticated?
  end

  def dashboard
    # Some wonderful code I guess
  end
end
