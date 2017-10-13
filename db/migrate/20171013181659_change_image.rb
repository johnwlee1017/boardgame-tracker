class ChangeImage < ActiveRecord::Migration[5.1]
  def change
    change_column_default :boardgames, :image, "http://bit.ly/2jvyaxH"
  end
end
