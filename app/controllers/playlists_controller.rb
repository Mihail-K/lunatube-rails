# frozen_string_literal: true
class PlaylistsController < ApplicationController
  before_action :set_playlists, except: :create
  before_action :set_playlist, except: %i(index create)

  def index
    @playlists = authorize(@playlists).page(params[:page]).per(params[:count])

    render json: @playlists, meta: meta_for(@playlists)
  end

  def show
    render json: authorize(@playlist)
  end

  def create
    @playlist = Playlist.new(permitted_attributes(Playlist)) do |playlist|
      playlist.creator = current_user
    end
    authorize(@playlist).save!

    render json: @playlist, status: :created, location: @playlist
  end

  def update
    authorize(@playlist).update!(permitted_attributes(@playlist))

    render json: @playlist
  end

  def destroy
    authorize(@playlist).destroy!
  end

private

  def set_playlists
    @playlists = policy_scope(Playlist).includes(:creator)
  end

  def set_playlist
    @playlist = @playlists.find(params[:id])
  end
end
