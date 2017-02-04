# frozen_string_literal: true
class RoomSerializer < ApplicationSerializer
  attribute :id
  attribute :owner_id
  attribute :playlist_item_id

  attribute :name
  attribute :status
  attribute :media_offset

  attribute :media_started_at
  attribute :last_online_at
  attribute :created_at
  attribute :updated_at

  has_one :owner
  has_one :playlist_item
  has_one :playlist
end
