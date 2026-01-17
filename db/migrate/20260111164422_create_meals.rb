class CreateMeals < ActiveRecord::Migration[8.1]
  def change
    create_table :meals do |t|
      t.string :item, null: false, default: ""
      t.integer :calories, null: false, default: 0
      t.integer :carbs, null: false, default: 0
      t.integer :fats, null: false, default: 0
      t.integer :protein, null: false, default: 0
      t.timestamps
    end
  end
end


