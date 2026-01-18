# lib/coach/meal_processor.rb
require 'date'

module Coach
  module MealProcessor
    def self.enter_meals
      meals = []
      
      puts "\n"
      puts "="*80
      puts "MEAL ENTRY"
      puts "="*80
      puts "Enter your meals for today. Type 'done' when finished."
      puts "Example: '6 oz chicken breast' or '1 cup rice'"
      puts "\n"
      
      loop do
        print "Would you like to enter #{meals.any? ? 'another' : "you're first"} meal? (yes/no): "
        answer = gets.chomp.downcase
        
        break if answer == 'no'
        
        print "Enter meal type for this entry: "
        meal_type = gets.chomp
        
        puts "\n"
        
        loop do
          print "Enter food item  (or 'done' to finish): "
          item = gets.chomp
          
          break if item.downcase == 'done'
          
          next if item.strip.empty?
          
          puts "  Analyzing '#{item}'..."
            
          prompt = PromptBuilder.build_meal_item_prompt(meal_type, item)
          analyzer = Analyzer.new(prompt)
          analysis = analyzer.analyze_data
            
          parsed_item = JsonParser.parse(analysis, validation_type: :meal_item)
          
          if parsed_item.nil?
            puts "  ✗ Error: Could not analyze this item. Please try again."
            next
          end
        
          meals << { **parsed_item, meal_type: meal_type }
            
          puts "  ✓ Added: #{parsed_item['item']}"
          puts "    Calories: #{parsed_item['calories']} | Protein: #{parsed_item['protein']}g | Carbs: #{parsed_item['carbs']}g | Fats: #{parsed_item['fats']}g"
          puts "\n"
        end
      end
      
      meals
    end

    def self.save_meals(meals)
      return if meals.empty?
      
      meals.each do |meal_data|
        Meal.create(
          item: meal_data['item'],
          calories: meal_data['calories'],
          protein: meal_data['protein'],
          carbs: meal_data['carbs'],
          fats: meal_data['fats'],
          # created_at: Date.today,
          meal_type: meal_data['meal_type']
        )
      end
      
      puts "\n✓ Saved #{meals.count} meal(s) to database."
    end

    def self.process
      current_goal = Goal.last
      
      unless current_goal
        puts "\n⚠️  No goal found! Please enter your body stats first to set macro goals."
        return
      end
      
      meals = enter_meals
      
      if meals.empty?
        puts "\nNo meals entered."
        return
      end
      
      puts "\n"
      puts "Meals to save:"
      meals.each_with_index do |meal, i|
        puts "  #{i+1}. #{meal['item']} - #{meal['calories']}cal, #{meal['protein']}g protein, #{meal['carbs']}g carbs, #{meal['fats']}g fats"
      end
      
      print "\nSave these meals and get analysis? (y/n): "
      confirm = gets.chomp.downcase
      
      return unless confirm.match?(/^y(es)?$/)
      
      save_meals(meals)
      
      prompt = PromptBuilder.build_meal_summary_prompt(meals, current_goal)
      
      analyzer = Analyzer.new(prompt)
      analysis = analyzer.analyze_data
      
      parsed_analysis = JsonParser.parse(analysis, validation_type: :meal_analysis)
      
      if parsed_analysis.nil?
        puts "Error: Unable to parse meal analysis response."
        return
      end
      
      MealSummary.display_meal_summary(parsed_analysis, current_goal)
    end
  end
end