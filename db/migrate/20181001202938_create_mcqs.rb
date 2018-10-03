class CreateMcqs < ActiveRecord::Migration[5.2]
  def change
    create_table :mcqs do |t|
      t.jsonb :options

      t.timestamps
    end
  end
end
