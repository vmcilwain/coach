class CreateGoals < ActiveRecord::Migration[8.1]
  def change
    create_table :goals do |t|
      t.decimal :weight, null: false, default: 0.0, precision: 5, scale: 2
      t.decimal :fat_mass, null: false, default: 0.0, precision: 5, scale: 2
      t.decimal :body_fat_percent, null: false, default: 0.0, precision: 5, scale: 2
      t.integer :calories
      t.integer :carbs
      t.integer :fats
      t.integer :protein
      t.timestamps
    end
  end
end
