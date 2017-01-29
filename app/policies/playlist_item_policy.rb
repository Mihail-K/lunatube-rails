# frozen_string_literal: true
class PlaylistItemPolicy < ApplicationPolicy
  alias playlist_item record

  def index?
    true
  end

  def create?
    authenticated?
  end

  def update?
    # TODO : Figure out what this condition should be.
    playlist_item.playlist.creator == current_user
  end

  alias destroy? update?

  def permitted_attributes_for_create
    [:playlist_position, :media_type, :media_url]
  end

  def permitted_attributes_for_update
    [:playlist_position]
  end
end
