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

FactoryGirl.define do
  factory :room do
    association :owner, strategy: :build, factory: :user

    name { Faker::Book.title }
    status 'offline'

    trait :playing do
      status 'playing'
    end

    trait :paused do
      status 'paused'
    end
  end
end
