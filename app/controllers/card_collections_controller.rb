class CardCollectionsController < ApplicationController
  before_action :authenticate!, except: [:index, :show]
  before_action :set_card_collection, except: :index

  rescue_from CanCan::AccessDenied, with: :forbidden

  def index
    @collections = CardCollection.visible_for(current_user)
  end

  def new
    # TODO: Maybe add folders or something to make organizing collections easy
  end

  def create
    card_collection = current_user.card_collections.create card_collection_params
    redirect_to card_collection_path(card_collection)
  end

  def show
    authorize! :view, @card_collection
  end

  def edit
    authorize! :manage, @card_collection
  end

  def update
    authorize! :manage, @card_collection
    @card_collection.update card_collection_params

    redirect_to card_collection_path(@card_collection)
  end

  def destroy
    authorize! :manage, @card_collection
    @card_collection.destroy

    redirect_to card_collections_path
  end

  private

  def card_collection_params
    params.require(:card_collection).permit(:title, :is_public)
  end

  def set_card_collection
    @card_collection = CardCollection.find_by id: params[:id]
  end
end
