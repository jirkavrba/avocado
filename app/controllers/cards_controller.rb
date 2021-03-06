# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :authenticate!, unless: -> { request.format.json? }
  before_action :set_card, except: [:new, :index]
  before_action :set_card_collection

  def index
    @cards = @card_collection.cards

    respond_to do |format|
      format.html # Render the template
      format.json { render json: @cards.shuffle }
    end
  end

  def new
    @card = @card_collection.cards.new
  end

  def create
    card = @card_collection.cards.create card_params

    return redirect_to return_url if card.valid?

    flash[:alert] = card.errors.full_messages.first
    redirect_to new_card_collection_card_path(@card_collection)
  end

  def edit
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

  def set_card_collection
    @card_collection = CardCollection.find_by id: params[:card_collection_id]
    authorize! :view, @card_collection
    authorize! :manage, @card_collection unless request.format.json?
  end

  def set_card
    @card = Card.find_by id: params[:id]
  end

  def card_params
    params.require(:card).permit(:title, :question, :answer)
  end

  def return_url
    if params.key?(:return)
      card_collection_path(@card_collection)
    else
      new_card_collection_card_path(@card_collection)
    end
  end
end
