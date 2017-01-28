# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  describe '#GET index' do
    let!(:playlists) { create_list(:playlist, 3) }

    it 'returns a list of playlists' do
      get :index

      expect(response).to have_http_status :ok
    end
  end

  describe '#GET show' do
    let(:playlist) { create(:playlist) }

    it 'returns the requested playlist' do
      get :show, params: { id: playlist.id }

      expect(response).to have_http_status :ok
    end
  end
end
