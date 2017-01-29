# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PlaylistItemPolicy do
  let(:user) { build(:user) }
  subject { described_class }

  permissions :create? do
    it "doesn't allow guests to add items to playlists" do
      should_not permit(nil, PlaylistItem)
    end

    it 'allows users to add items to playlists' do
      should permit(user, PlaylistItem)
    end
  end
end
