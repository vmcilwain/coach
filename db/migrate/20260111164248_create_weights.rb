class CreateWeights < ActiveRecord::Migration[8.1]
  def change
    create_table :weights do |t|
      t.decimal :weight, null: false, default: 0.0, precision: 5, scale: 2
      t.decimal :fat_mass, null: false, default: 0.0, precision: 5, scale: 2
      t.timestamps
      t.decimal :fat_percentage
      t.decimal :muscle_mass
      t.decimal :muscle_percentage
    end
  end
end
