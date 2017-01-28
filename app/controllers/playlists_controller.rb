# frozen_string_literal: true
class PlaylistsController < ApplicationController
  before_action :set_playlists, except: :create
  before_action :set_playlist, except: %i(index create)

  def index
    @playlists = @playlists.page(params[:page]).per(params[:count])

    render json: @playlists, meta: meta_for(@playlists)
  end

  def show
    render json: @playlists
  end

  def create
    @playlist = Playlist.create!(playlist_params) do |playlist|
      playlist.creator = current_user
    end

    render json: @playlist, status: :created, location: @playlist
  end

  def update
    @playlist.update!(playlist_params)

    render json: @playlist
  end

  def destroy
    @playlist.destroy!
  end

private

  def playlist_params
    params.require(:playlist).permit(:name, playlist_items_attributes: [
      :id, :playlist_position, :media_type, :media_url, :_destroy
    ])
  end

  def set_playlists
    @playlists = Playlist.all
  end

  def set_playlist
    @playlist = @playlists.find(params[:id])
  end
end
