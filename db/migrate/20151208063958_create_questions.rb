class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :research, index: true, foreign_key: true
      t.text :text
      t.pass_answer :integer

      t.timestamps null: false
    end
  end
end
