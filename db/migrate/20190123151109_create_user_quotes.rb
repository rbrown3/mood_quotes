class CreateUserQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_quotes do |t|
      t.integer :user_id
      t.integer :quote_id
      t.timestamps
    end
  end
end
