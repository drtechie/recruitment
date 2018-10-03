class CreateAttemptsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts_categories do |t|
      t.references :attempt, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
