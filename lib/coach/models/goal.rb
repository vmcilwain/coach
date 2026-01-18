module Coach
  class Goal < ActiveRecord::Base
    validates :weight, :fat_mass, :body_fat_percent, presence: true 
  end
end
