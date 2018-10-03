class CreateInterviewees < ActiveRecord::Migration[5.2]
  def change
    create_table :interviewees do |t|
      t.string :auth_code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
