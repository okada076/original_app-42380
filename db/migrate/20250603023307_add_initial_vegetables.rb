class AddInitialVegetables < ActiveRecord::Migration[7.1]
  def up
    Vegetable.create([
      { name: "トマト" }, 
      { name: "きゅうり" }, 
      { name: "にんじん" }, 
      { name: "レモン" }, 
      { name: "さつまいも" }, 
      { name: "なす" }, 
      { name: "カボチャ" }, 
      { name: "すだち" }, 
      { name: "じゃがいも" }, 
      { name: "レタス" },
      { name: "その他" }
    ])
  end

  def down
    Vegetable.delete_all
  end
end
