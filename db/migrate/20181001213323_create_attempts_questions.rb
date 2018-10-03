class CreateAttemptsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts_questions do |t|
      t.references :attempt, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
