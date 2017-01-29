# frozen_string_literal: true
class PlaylistPolicy < ApplicationPolicy
  alias playlist record

  def index?
    true
  end

  def create?
    authenticated?
  end

  def update?
    playlist.creator == current_user
  end

  alias destroy? update?

  def permitted_attributes_for_create
    [:name, playlist_items_attributes: [:playlist_position, :media_type, :media_url]]
  end

  def permitted_attributes_for_update
    [:name, playlist_items_attributes: [:id, :playlist_position, :_destroy]]
  end
end
