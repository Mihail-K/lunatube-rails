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

require 'rails_helper'

RSpec.describe PlaylistItem, type: :model do
  subject { build(:playlist_item) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without a playlist' do
    subject.playlist = nil
    should be_invalid
  end

  it 'is invalid without a creator' do
    subject.creator = nil
    should be_invalid
  end

  it 'is invalid without a playlist position' do
    subject.playlist_position = nil
    should be_invalid
  end

  it 'is invalid without a media type' do
    subject.media_type = nil
    should be_invalid
  end

  it 'is invalid without a media url' do
    subject.media_url = nil
    should be_invalid
  end

  it 'is invalid if the playlist position is negative' do
    subject.playlist_position = -1
    should be_invalid
  end

  it 'is invalid if the playlist position is greater than the playlist item count' do
    subject.playlist_position = subject.playlist_items_count + 1
    should be_invalid
  end

  context 'when adding to or removing from a playlist' do
    let!(:playlist) { create(:playlist) }
    let!(:other_item) { create(:playlist_item, playlist: playlist) }

    subject { build(:playlist_item, playlist: playlist) }

    it 'places the item at the end, when its position is last' do
      expect do
        subject.playlist_position = playlist.playlist_items_count
        subject.save
      end.not_to change { other_item.reload.playlist_position }
    end

    it 'shifts other items forwards, when inserted before them' do
      expect do
        subject.playlist_position = 0
        subject.save
      end.to change { other_item.reload.playlist_position }.from(0).to(1)
    end

    it 'shifts other items backwards, when removed from the playlist' do
      subject.playlist_position = 0
      subject.save

      expect do
        subject.destroy
      end.to change { other_item.reload.playlist_position }.from(1).to(0)
    end
  end

  context 'when moving an item in a playlist' do
    let!(:playlist) { create(:playlist) }
    let!(:other_items) { create_list(:playlist_item, 3, playlist: playlist) }

    it 'shifts other items forwards when moved towards the beginning' do
      expect do
        other_items.third.update(playlist_position: 0)
      end.to change { other_items.first.reload.playlist_position }.from(0).to(1)
        .and change { other_items.second.reload.playlist_position }.from(1).to(2)
    end

    it 'shifts other items backwards when moved towards the end' do
      expect do
        other_items.first.update(playlist_position: 2)
      end.to change { other_items.second.reload.playlist_position }.from(1).to(0)
        .and change { other_items.third.reload.playlist_position }.from(2).to(1)
    end
  end
end
