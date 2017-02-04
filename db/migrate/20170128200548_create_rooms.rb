# frozen_string_literal: true
class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.belongs_to :owner, null: false, index: true, foreign_key: { to_table: :users }
      t.belongs_to :playlist_item, index: true, foreign_key: { on_delete: :nullify }
      t.string     :name, null: false, index: { unique: true }
      t.string     :status, null: false, index: true, default: 'offline'
      t.integer    :media_offset, null: false, default: 0
      t.datetime   :media_started_at
      t.datetime   :last_online_at

      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          ALTER TABLE
            rooms
          ADD CONSTRAINT
            check_rooms_on_status
          CHECK
            (status IN ('playing', 'paused', 'offline'))
        SQL
      end
    end
  end
end
