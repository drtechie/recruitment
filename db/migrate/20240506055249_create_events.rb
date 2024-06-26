class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.json :params
      t.references :attempt, foreign_key: true

      t.timestamps
    end
  end
end
