# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PlaylistPolicy do
  let(:user) { build(:user) }
  subject { described_class }

  permissions :create? do
    it "doesn't allow guests to create playlists" do
      should_not permit(nil, Playlist)
    end

    it 'allows users to create playlists' do
      should permit(user, Playlist)
    end
  end

  permissions :update? do
    let(:playlist) { build(:playlist, creator: user) }

    it "doesn't allow guests to edit playlists" do
      should_not permit(nil, playlist)
    end

    it 'allows users to edit the playlists they created' do
      should permit(user, playlist)
    end

    it "doesn't allow users to edit playlists created by other users" do
      playlist.creator = build(:user)
      should_not permit(user, playlist)
    end
  end

  permissions :destroy? do
    let(:playlist) { build(:playlist, creator: user) }

    it "doesn't allow guests to delete playlists" do
      should_not permit(nil, playlist)
    end

    it 'allows users to delete the playlists they created' do
      should permit(user, playlist)
    end

    it "doesn't allow users to delete playlists created by other users" do
      playlist.creator = build(:user)
      should_not permit(user, playlist)
    end
  end
end
