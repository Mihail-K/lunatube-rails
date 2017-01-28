# frozen_string_literal: true
class PlaylistItemSerializer < ApplicationSerializer
  attribute :id
  attribute :playlist_id
  attribute :creator_id

  attribute :playlist_position
  attribute :media_type
  attribute :media_url

  attribute :created_at
  attribute :updated_at

  has_one :playlist
  has_one :creator
end
