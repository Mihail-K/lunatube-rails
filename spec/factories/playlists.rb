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

FactoryGirl.define do
  factory :playlist do
    association :creator, strategy: :build, factory: :user

    name { Faker::Book.title }
  end
end
