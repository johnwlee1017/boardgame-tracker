class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user
      t.references :friend
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
