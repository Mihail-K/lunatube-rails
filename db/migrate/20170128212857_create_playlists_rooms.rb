# frozen_string_literal: true
class CreatePlaylistsRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists_rooms do |t|
      t.belongs_to :playlist, null: false, index: true, foreign_key: true, on_delete: :cascade
      t.belongs_to :room, null: false, index: true, foreign_key: true, on_delete: :cascade
      t.index      %i(playlist_id room_id), unique: true

      t.timestamps null: false
    end
  end
end
