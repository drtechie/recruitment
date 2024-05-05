class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :domain
      t.string :name
      t.json :config

      t.timestamps
    end
  end
end
