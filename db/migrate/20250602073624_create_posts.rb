class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category, null: false
      t.references :vegetable, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end