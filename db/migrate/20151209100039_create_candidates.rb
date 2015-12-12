class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :research, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
