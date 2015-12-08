class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :research, index: true, foreign_key: true
      t.text :text
      t.integer :pass_answer

      t.timestamps null: false
    end
  end
end
