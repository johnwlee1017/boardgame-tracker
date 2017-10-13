class CreateBoardgames < ActiveRecord::Migration[5.1]
  def change
    create_table :boardgames do |t|
      t.string :name, null:false
      t.text :description, null:false
      t.string :genre, null:false
      t.integer :players, null:false
      t.integer :owner_id, null:false
      t.integer :play_time, null:false
      t.string :image

      t.timestamps
    end
  end
end
