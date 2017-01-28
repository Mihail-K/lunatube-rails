# frozen_string_literal: true
class CreatePlaylistItems < ActiveRecord::Migration[5.0]
  def change
    create_table :playlist_items do |t|
      t.belongs_to :playlist, null: false, index: true, foreign_key: true
      t.belongs_to :creator, null: false, index: true, foreign_key: { to_table: :users }
      t.integer    :playlist_position, null: false
      t.string     :media_type, null: false
      t.string     :media_url, null: false

      t.timestamps null: false
    end
  end
end
