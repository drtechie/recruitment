class CreateMcqs < ActiveRecord::Migration[5.2]
  def change
    create_table :mcqs do |t|
      t.text :options, array: true, default: []
      t.integer :correct_options, array: true, default: []
      t.timestamps
    end
  end
end
