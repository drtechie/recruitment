class CreateCategoriesQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_questions do |t|
      t.references :category, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
