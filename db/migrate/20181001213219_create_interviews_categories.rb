class CreateInterviewsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :interviews_categories do |t|
      t.references :interview, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
