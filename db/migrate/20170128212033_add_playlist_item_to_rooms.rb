# frozen_string_literal: true
class AddPlaylistItemToRooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :rooms, :playlist_item, foreign_key: true, index: true
  end
end
