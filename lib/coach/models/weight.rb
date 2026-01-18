module Coach
  class Weight < ActiveRecord::Base
    validates :weight, :fat_mass, presence: true
  end
end
