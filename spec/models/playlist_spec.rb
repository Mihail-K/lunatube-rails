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

require 'rails_helper'

RSpec.describe Playlist, type: :model do
  subject { build(:playlist) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without a creator' do
    subject.creator = nil
    should be_invalid
  end
end
