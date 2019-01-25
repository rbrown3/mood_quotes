class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :mood
      t.string :content
      t.string :author
  end
  end
end
