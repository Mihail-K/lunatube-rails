# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PlaylistItemsController, type: :controller do
  describe '#GET index' do
    let!(:playlist_items) { create_list(:playlist_item, 3) }

    it 'returns a list of playlist items' do
      get :index

      expect(response).to have_http_status :ok
    end
  end

  describe '#GET show' do
    let!(:playlist_item) { create(:playlist_item) }

    it 'returns the requested playlist item' do
      get :show, params: { id: playlist_item.id }

      expect(response).to have_http_status :ok
    end
  end
end
