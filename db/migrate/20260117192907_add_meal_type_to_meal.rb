class AddMealTypeToMeal < ActiveRecord::Migration[8.1]
  def change
    add_column :meals, :meal_type, :string
  end
end
