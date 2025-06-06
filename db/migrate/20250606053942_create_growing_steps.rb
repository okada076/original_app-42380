class CreateGrowingSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :growing_steps do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :step_number, null: false
      t.references :vegetable, null: false, foreign_key: true

      t.timestamps
    end
  end
end
