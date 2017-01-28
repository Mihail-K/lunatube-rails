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

FactoryGirl.define do
  factory :playlist_item do
    association :playlist, strategy: :build
    creator { playlist&.creator || build(:user) }

    playlist_position { playlist&.playlist_items_count || 0 }
    media_type 'youtube'
    media_url  'foo/bar'
  end
end
