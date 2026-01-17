module Coach
  class Calculator
    def initialize(weight, body_fat_percentage)
      @weight = weight
      @body_fat_percentage = body_fat_percentage
    end

    def calculate_muscle_percentage
      (100 - @body_fat_percentage).round(2)
    end

    def calculate_fat_mass
      (@weight * @body_fat_percentage / 100).round(2)
    end

    def calculate_muscle_mass
      (@weight * calculate_muscle_percentage / 100).round(2)
    end
  end
end
