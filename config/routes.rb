# frozen_string_literal: true
Rails.application.routes.draw do
  resources :playlists
  resources :playlist_items
end
