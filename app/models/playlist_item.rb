# frozen_string_literal: true
# == Schema Information
#
# Table name: playlist_items
#
#  id                :integer          not null, primary key
#  playlist_id       :integer          not null
#  creator_id        :integer          not null
#  playlist_position :integer          not null
#  media_type        :string           not null
#  media_url         :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_playlist_items_on_creator_id   (creator_id)
#  index_playlist_items_on_playlist_id  (playlist_id)
#

class PlaylistItem < ApplicationRecord
  belongs_to :playlist, inverse_of: :playlist_items, counter_cache: true
  belongs_to :creator, class_name: 'User'

  delegate :playlist_items_count, to: :playlist, allow_nil: true

  validates :playlist, :creator, :playlist_position, :media_type, :media_url, presence: true
  validates :playlist_position, numericality: {
    greater_than_or_equal_to: 0, less_than_or_equal_to: :playlist_items_count, if: :playlist_position?
  }

  before_create :slide_trailing_items_forwards
  before_update :slide_intervening_items_forwards, if: -> { playlist_position_was > playlist_position }
  before_update :slide_intervening_items_backwards, if: -> { playlist_position_was < playlist_position }
  after_destroy :slide_trailing_items_backwards

  scope :between, -> (lower, upper = Float::INFINITY) { where(playlist_position: lower..upper) }

  def self.slide_items_forwards
    update_all('playlist_position = playlist_position + 1')
  end

  def self.slide_items_backwards
    update_all('playlist_position = playlist_position - 1')
  end

private

  def other_playlist_items
    playlist.playlist_items.where.not(id: id)
  end

  def slide_trailing_items_forwards
    other_playlist_items.between(playlist_position).slide_items_forwards
  end

  def slide_intervening_items_forwards
    other_playlist_items.between(playlist_position, playlist_position_was).slide_items_forwards
  end

  def slide_intervening_items_backwards
    other_playlist_items.between(playlist_position_was, playlist_position).slide_items_backwards
  end

  def slide_trailing_items_backwards
    other_playlist_items.between(playlist_position).slide_items_backwards
  end
end
