# frozen_string_literal: true

class CardCollectionsController < ApplicationController
  before_action :authenticate!, except: [:index, :show]
  before_action :set_card_collection, except: :index

  rescue_from CanCan::AccessDenied, with: :not_found_or_forbidden

  def index
    @collections = CardCollection.visible_for(current_user).preload(:user, :subject)
  end

  def new
    @subjects = Subject.all
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
    @subjects = Subject.all
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
    params.require(:card_collection).permit(:title, :is_public, :subject_id)
  end

  def set_card_collection
    @card_collection = CardCollection.find_by(id: params[:id])
  end

  def not_found_or_forbidden
    @card_collection.nil? ? not_found : forbidden
  end
end
