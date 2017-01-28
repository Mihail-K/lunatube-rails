# frozen_string_literal: true
class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.belongs_to :creator, null: false, index: true, foreign_key: { to_table: :users }
      t.string     :name, null: false
      t.integer    :playlist_items_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
