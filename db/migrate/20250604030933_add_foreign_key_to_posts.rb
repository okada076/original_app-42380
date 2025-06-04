class AddForeignKeyToPosts < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :posts, :users
    add_foreign_key :posts, :vegetables
  end
end
