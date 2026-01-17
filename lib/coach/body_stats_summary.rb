module Coach
  module BodyStatsSummary
    def self.display_body_stats_summary(parsed_analysis)
      puts "\n"
      puts "="*80
      puts "BODY COMPOSITION ANALYSIS"
      puts "="*80
      puts "\n"
      
      puts "📊 Current Stats:"
      puts "  Weight:              #{parsed_analysis['current_weight']} lbs"
      puts "  Body Fat Mass:       #{parsed_analysis['body_fat_mass']} lbs"
      puts "  Body Fat %:          #{parsed_analysis['body_fat_percentage']}%"
      puts "  Muscle Mass:         #{parsed_analysis['muscle_mass']} lbs"
      puts "  Muscle %:            #{parsed_analysis['muscle_percentage']}%"
      
      puts "\n"
      puts "💪 Coach's Assessment:"
      puts "  #{parsed_analysis['summary']}"
      
      puts "\n"
      puts "📋 Detailed Recommendations:"
      puts "  #{wrap_text(parsed_analysis['details'], 76)}"
      
      puts "\n"
      puts "🎯 Macro Goals (500 cal deficit):"
      puts "  Calories:            #{parsed_analysis['macro_goals']['calories']} kcal"
      puts "  Protein:             #{parsed_analysis['macro_goals']['protein']}g"
      puts "  Carbs:               #{parsed_analysis['macro_goals']['carbs']}g"
      puts "  Fats:                #{parsed_analysis['macro_goals']['fats']}g"
      
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
