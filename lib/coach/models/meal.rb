module Coach
  class Meal < ActiveRecord::Base
    validates :meal_type, :item, presence: true
  end
end
