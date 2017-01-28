# frozen_string_literal: true
class PlaylistSerializer < ApplicationSerializer
  attribute :id
  attribute :creator_id

  attribute :name
  attribute :playlist_items_count

  attribute :created_at
  attribute :updated_at

  has_one :creator
end
