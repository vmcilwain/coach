module Coach
  module MealSummary
    def self.display_meal_summary(parsed_analysis, goal)
      puts "\n"
      puts "="*80
      puts "MEAL INTAKE ANALYSIS"
      puts "="*80
      puts "\n"
      
      puts "🎯 Daily Macro Goals:"
      puts "  Calories:            #{goal.calories} kcal"
      puts "  Protein:             #{goal.protein}g"
      puts "  Carbs:               #{goal.carbs}g"
      puts "  Fats:                #{goal.fats}g"
      
      puts "\n"
      puts "📊 Today's Intake:"
      puts "  Calories:            #{parsed_analysis['total_calories']} kcal"
      puts "  Protein:             #{parsed_analysis['total_protein']}g"
      puts "  Carbs:               #{parsed_analysis['total_carbs']}g"
      puts "  Fats:                #{parsed_analysis['total_fats']}g"
      
      puts "\n"
      puts "📈 Remaining:"
      puts "  Calories:            #{parsed_analysis['calories_remaining']} kcal"
      puts "  Protein:             #{parsed_analysis['protein_remaining']}g"
      puts "  Carbs:               #{parsed_analysis['carbs_remaining']}g"
      puts "  Fats:                #{parsed_analysis['fats_remaining']}g"
      
      progress_status = parsed_analysis['progress_status'] || 'unknown'
      status_icon = case progress_status
                    when 'on_track' then '✅'
                    when 'over_target' then '⚠️'
                    when 'under_target' then '📉'
                    else '📊'
                    end
      
      puts "\n"
      puts "#{status_icon} Status: #{progress_status.gsub('_', ' ').capitalize}"
      
      puts "\n"
      puts "💪 Coach's Assessment:"
      puts "  #{parsed_analysis['summary'] || 'No summary available'}"
      
      puts "\n"
      puts "📋 Recommendations:"
      details = parsed_analysis['details'] || 'No recommendations available'
      puts "  #{wrap_text(details, 76)}"
      
      puts "\n"
      puts "="*80
      puts "\n"
    end

    def self.wrap_text(text, width)
      words = text.split(' ')
      lines = []
      current_line = ""
      
      words.each do |word|
        if (current_line + word).length > width
          lines << current_line.strip
          current_line = "  #{word} "
        else
          current_line += "#{word} "
        end
      end
      
      lines << current_line.strip unless current_line.strip.empty?
      lines.join("\n")
    end
  end
end
