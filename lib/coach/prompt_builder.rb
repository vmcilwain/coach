module Coach
  module PromptBuilder
    def self.build_body_stats_prompt(current_weight, fat_mass, fat_percentage, muscle_mass, muscle_percentage)
      <<~PROMPT
      You are Hani Rambod, famous IFBB bodybuilding coach. Analyze these stats and provide recommendations:

      - weight: #{current_weight} lbs
      - body fat mass: #{fat_mass} lbs
      - body fat percentage: #{fat_percentage}%
      - muscle mass: #{muscle_mass} lbs
      - muscle percentage: #{muscle_percentage}%

      CRITICAL: You MUST respond with ONLY valid JSON. No other text.

      JSON REQUIREMENTS:
      1. Start with { and end with }
      2. Include ALL commas between fields
      3. NO newlines inside string values - write as continuous text
      4. NO markdown, NO explanations, ONLY the JSON object
      5. Match this EXACT structure with these EXACT field names:

      {
        "current_weight": 180.5,
        "body_fat_mass": 36.1,
        "body_fat_percentage": 20.0,
        "muscle_mass": 144.4,
        "muscle_percentage": 80.0,
        "summary": "Brief analysis in coach tone",
        "details": "All recommendations in one paragraph: workout routines, diet adjustments, supplements, and recovery strategies.",
        "macro_goals": {
          "calories": 2000,
          "carbs": 200,
          "fats": 67,
          "protein": 180
        }
      }

      YOU MUST INCLUDE THE "macro_goals" OBJECT WITH ALL FOUR FIELDS: calories, carbs, fats, protein.
      Calculate macro_goals for a 500 calorie deficit. Write details as ONE paragraph with no line breaks.
      DO NOT add any fields not shown in the example. DO NOT omit any fields from the example.
      PROMPT
    end

    def self.build_meal_summary_prompt(meals, goal)
      total_calories = meals.sum { |m| m['calories'] || 0 }
      total_protein = meals.sum { |m| m['protein'] || 0 }
      total_carbs = meals.sum { |m| m['carbs'] || 0 }
      total_fats = meals.sum { |m| m['fats'] || 0 }
      
      calories_remaining = goal.calories - total_calories
      protein_remaining = goal.protein - total_protein
      carbs_remaining = goal.carbs - total_carbs
      fats_remaining = goal.fats - total_fats
      
      meal_list = meals.map { |m| "- #{m['item']}: #{m['calories']}cal, #{m['protein']}g protein, #{m['carbs']}g carbs, #{m['fats']}g fats" }.join("\n  ")
      
      <<~PROMPT
      You are Hani Rambod, famous IFBB bodybuilding coach. Analyze this meal intake against the daily macro goals:

      TODAYS MEALS CONSUMED:
      #{meal_list}

      ACTUAL TOTALS CONSUMED TODAY:
      - Calories consumed: #{total_calories} kcal
      - Protein consumed: #{total_protein}g
      - Carbs consumed: #{total_carbs}g
      - Fats consumed: #{total_fats}g

      DAILY GOALS:
      - Calorie goal: #{goal.calories} kcal
      - Protein goal: #{goal.protein}g
      - Carbs goal: #{goal.carbs}g
      - Fats goal: #{goal.fats}g

      REMAINING FOR THE DAY:
      - Calories remaining: #{calories_remaining} kcal
      - Protein remaining: #{protein_remaining}g
      - Carbs remaining: #{carbs_remaining}g
      - Fats remaining: #{fats_remaining}g

      CRITICAL: You MUST respond with ONLY valid JSON. No other text.

      JSON REQUIREMENTS:
      1. Start with { and end with }
      2. Include ALL commas between fields
      3. NO newlines inside string values - write as continuous text
      4. NO markdown, NO explanations, ONLY the JSON object
      5. Use the EXACT numbers provided above - do not recalculate
      6. Match this EXACT structure with these EXACT field names:

      {
        "total_calories": #{total_calories},
        "total_protein": #{total_protein},
        "total_carbs": #{total_carbs},
        "total_fats": #{total_fats},
        "calories_remaining": #{calories_remaining},
        "protein_remaining": #{protein_remaining},
        "carbs_remaining": #{carbs_remaining},
        "fats_remaining": #{fats_remaining},
        "summary": "Brief analysis of meal intake progress in coach tone",
        "details": "Detailed feedback on meal choices, what to adjust for remaining meals, and recommendations as one continuous paragraph.",
        "progress_status": "on_track or over_target or under_target"
      }

      Use the exact numbers shown above in your JSON response. Write details as ONE paragraph with no line breaks.
      DO NOT add any fields not shown in the example. DO NOT omit any fields from the example.
      PROMPT
    end

    def self.build_meal_item_prompt(meal_type, item)
      <<~PROMPT
      You are a nutrition expert. Calculate the macronutrients for this food item: "#{item}"

      CRITICAL: You MUST respond with ONLY valid JSON. No other text. ONLY process the item given to you. DO NOT make assumptions or add extra items.

      JSON REQUIREMENTS:
      1. Start with { and end with }
      2. Include ALL commas between fields
      3. NO newlines inside string values - write as continuous text
      4. NO markdown, NO explanations, ONLY the JSON object
      5. Match this EXACT structure with these EXACT field names:

      {
        "meal_type": "#{meal_type}",
        "item": "6 oz chicken breast",
        "calories": 280,
        "protein": 53,
        "carbs": 0,
        "fats": 6
      }

      Calculate accurate macronutrients based on standard nutrition data for the specified food item and quantity.
      DO NOT add any fields not shown in the example. DO NOT omit any fields from the example.
      PROMPT
    end
  end
end
