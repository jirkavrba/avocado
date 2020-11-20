class CardCollectionsController < ApplicationController
  before_action :authenticate!, except: [:index]

  def index
    @collections = CardCollection.visible_for(current_user)
    render json: @collections
  end

  def new
    # TODO: Maybe add folders or something to make organizing collections easy
  end
end
