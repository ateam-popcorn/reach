class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :sex
      t.date :birthday
      t.integer :age
      t.integer :prefecture
      t.integer :job

      t.timestamps null: false
    end
  end
end
