# frozen_string_literal: true
# == Schema Information
#
# Table name: playlists
#
#  id                   :integer          not null, primary key
#  creator_id           :integer          not null
#  name                 :string           not null
#  playlist_items_count :integer          default("0"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_playlists_on_creator_id  (creator_id)
#

class Playlist < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :playlist_items, inverse_of: :playlist
  accepts_nested_attributes_for :playlist_items, allow_destroy: true

  has_and_belongs_to_many :rooms, inverse_of: :playlists

  validates :name, presence: true
end
