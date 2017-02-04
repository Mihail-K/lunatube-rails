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

require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { build(:room) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an owner' do
    subject.owner = nil
    should be_invalid
  end

  it 'is invalid without a name' do
    subject.name = nil
    should be_invalid
  end

  it 'is invalid without a status' do
    subject.status = nil
    should be_invalid
  end

  it 'is invalid when a room with the same name exists' do
    create :room, name: subject.name
    should be_invalid
  end

  it 'sets the media-started-at timestamp when it changes to playing' do
    expect do
      subject.status = 'playing'
      subject.save
    end.to change { subject.media_started_at }
  end

  it 'calculates a media offset when the media stops playing' do
    subject.playing!

    expect do
      subject.update(media_started_at: 5.minutes.ago)
      subject.paused!
    end.to change { subject.media_offset }.from(0).to be_within(1).of(300)
  end
end
