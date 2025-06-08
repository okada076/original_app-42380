class CreateStepProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :step_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :growing_step, null: false, foreign_key: true
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
