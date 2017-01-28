# frozen_string_literal: true
# == Schema Information
#
# Table name: rooms
#
#  id               :integer          not null, primary key
#  owner_id         :integer          not null
#  name             :string           not null
#  status           :string           default("offline"), not null
#  media_offset     :integer          default("0"), not null
#  last_online_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  playlist_item_id :integer
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

  enum status: {
    playing: 'playing',
    paused:  'paused',
    offline: 'offline'
  }

  validates :owner, :name, :status, :media_offset, presence: true
  validates :name, uniqueness: true, if: -> { new_record? || name_changed? }

  before_save :set_last_online_at, if: -> { status_changed?(to: 'offline') }

private

  def set_last_online_at
    self.last_online_at = Time.current
  end
end
