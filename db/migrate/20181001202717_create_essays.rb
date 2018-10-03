class CreateEssays < ActiveRecord::Migration[5.2]
  def change
    create_table :essays do |t|
      t.integer :answer_min_length
      t.integer :answer_max_length

      t.timestamps
    end
  end
end
