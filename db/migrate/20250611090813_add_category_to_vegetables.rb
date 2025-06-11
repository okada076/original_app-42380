class AddCategoryToVegetables < ActiveRecord::Migration[7.1]
  def change
    add_column :vegetables, :category, :string
  end
end
