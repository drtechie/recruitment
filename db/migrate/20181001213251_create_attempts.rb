class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.references :interviewee, foreign_key: true
      t.references :interview, foreign_key: true
      t.jsonb :response

      t.timestamps
    end
  end
end
