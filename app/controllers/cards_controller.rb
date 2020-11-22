class CardsController < ApplicationController
  before_action :authenticate!
  before_action :set_card_collection

  rescue_from CanCan::AccessDenied, with: :forbidden

  def index
    @cards = @card_collection.cards
  end

  def new
    @card = @card_collection.cards.new
  end

  def create
    @card_collection.cards.create! card_params
    redirect_to card_collection_cards_path(@card_collection)
  end

  private

  def set_card_collection
    @card_collection = CardCollection.find_by id: params[:card_collection_id]
    authorize! :manage, @card_collection
  end

  def card_params
    params.require(:card).permit(:title, :question, :answer)
  end
end
