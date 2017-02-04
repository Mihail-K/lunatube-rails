# frozen_string_literal: true
# == Schema Information
#
# Table name: rooms
#
#  id               :integer          not null, primary key
#  owner_id         :integer          not null
#  playlist_item_id :integer
#  name             :string           not null
#  status           :string           default("offline"), not null
#  media_offset     :integer          default("0"), not null
#  media_started_at :datetime
#  last_online_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_rooms_on_name              (name) UNIQUE
#  index_rooms_on_owner_id          (owner_id)
#  index_rooms_on_playlist_item_id  (playlist_item_id)
#  index_rooms_on_status            (status)
#

class Room < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :playlist_item, optional: true

  has_one :playlist, through: :playlist_item

  has_and_belongs_to_many :playlists, inverse_of: :rooms

  enum status: {
    playing: 'playing',
    paused:  'paused',
    offline: 'offline'
  }

  validates :name, :status, :media_offset, presence: true
  validates :name, uniqueness: true, if: -> { new_record? || name_changed? }

  before_save :reset_media_offsets,  if: :playlist_item_id_changed?
  before_save :set_media_started_at, if: -> { status_changed?(to: 'playing') }
  before_save :set_media_offset,     if: -> { status_changed?(from: 'playing') }
  before_save :set_last_online_at,   if: -> { status_changed?(to: 'offline') }

private

  def reset_media_offsets
    self.media_started_at = Time.current
    self.media_offset     = 0
  end

  def set_media_started_at
    self.media_started_at = Time.current
  end

  def set_media_offset
    self.media_offset = media_started_at.nil? ? 0 : (Time.current - media_started_at).round
  end

  def set_last_online_at
    self.last_online_at = Time.current
  end
end
