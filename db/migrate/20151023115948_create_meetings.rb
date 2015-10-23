class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.references :research, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
