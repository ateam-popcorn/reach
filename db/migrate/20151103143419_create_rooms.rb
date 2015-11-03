class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :token
      t.references :meeting, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end