# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate!
  before_action :set_card, except: [:new, :index]
  before_action :set_card_collection

  before_action :set_breadcrumbs

  rescue_from CanCan::AccessDenied, with: :forbidden

  def index
    @cards = @card_collection.cards
  end

  def new
    breadcrumb 'Add a new card', new_card_collection_card_path(@card_collection)
    @card = @card_collection.cards.new
  end

  def create
    card = @card_collection.cards.create card_params

    if card.valid?
      redirect_url = (params.key?(:return) ? card_collection_path(@card_collection) : new_card_collection_card_path(@card_collection))
      return redirect_to redirect_url
    else
      flash[:alert] = card.errors.full_messages.first end

    redirect_to new_card_collection_card_path(@card_collection)
  end

  def edit
    breadcrumb @card.title, card_collection_card_path(@card_collection, @card)
    breadcrumb 'Edit', edit_card_collection_card_path(@card_collection, @card)
  end

  def update
    @card.update card_params
    redirect_to card_collection_cards_path(@card_collection)
  end

  def destroy
    @card.delete
    redirect_to card_collection_cards_path(@card_collection)
  end

  private

  def set_breadcrumbs
    breadcrumb 'Card collections', card_collections_path
    breadcrumb @card_collection.title, card_collection_path(@card_collection)
    breadcrumb 'Manage cards', card_collection_cards_path(@card_collection)
  end

  def set_card_collection
    @card_collection = CardCollection.find_by id: params[:card_collection_id]
    authorize! :manage, @card_collection
  end

  def set_card
    @card = Card.find_by id: params[:id]
  end

  def card_params
    params.require(:card).permit(:title, :question, :answer)
  end
end
