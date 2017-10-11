class CreateBoardgames < ActiveRecord::Migration[5.1]
  def change
    create_table :boardgames do |t|
      t.string :name
      t.text :description
      t.string :genre
      t.integer :players
      t.integer :owner_id
      t.integer :play_time
      t.string :image

      t.timestamps
    end
  end
end
