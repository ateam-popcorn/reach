class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.integer :reward
      t.integer :max_users
      t.integer :min_users

      t.timestamps null: false
    end
  end
end
