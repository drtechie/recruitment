class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.string :client_id
      t.references :user, foreign_key: true
      t.string :token
      t.datetime :expires

      t.timestamps
    end
    add_index :auth_tokens, [:user_id, :token, :expires]
  end
end
