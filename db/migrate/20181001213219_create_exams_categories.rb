class CreateExamsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :exams_categories do |t|
      t.references :exam, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
