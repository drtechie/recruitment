class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.references :questionable, polymorphic: true

      t.timestamps
    end
  end
end
