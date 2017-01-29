# frozen_string_literal: true
class PlaylistItemsController < ApplicationController
  before_action :set_playlist_items, except: :create
  before_action :set_playlist_item, except: %i(index create)

  def index
    @playlist_items = authorize(@playlist_items).page(params[:page]).per(params[:count])

    render json: @playlist_items, meta: meta_for(@playlist_items)
  end

  def show
    render json: authorize(@playlist_item)
  end

  def create
    @playlist_item = PlaylistItem.new(permitted_attributes(PlaylistItem)) do |playlist_item|
      playlist_item.creator = current_user
    end
    authorize(@playlist_item).save!

    render json: @playlist_item, status: :created, location: @playlist_item
  end

  def update
    authorize(@playlist_item).update!(permitted_attributes(@playlist_item))

    render json: @playlist_item
  end

  def destroy
    authorize(@playlist_item).destroy!
  end

private

  def set_playlist_items
    @playlist_items = policy_scope(PlaylistItem).includes(:creator, :playlist)
    @playlist_items = @playlist_items.where(playlist: params[:playlist_id]) if params[:playlist_id].present?
    @playlist_items = @playlist_items.order(playlist_position: :asc)
  end

  def set_playlist_item
    @playlist_item = @playlist_items.find(params[:id])
  end
end
