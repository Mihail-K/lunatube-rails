# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string     :name, null: false, index: { unique: true }
      t.string     :email, null: false, index: { unique: true }
      t.integer    :poniverse_id, null: false

      t.timestamps null: false
    end
  end
end
