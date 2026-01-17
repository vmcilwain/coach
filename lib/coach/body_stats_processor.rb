require 'date'

module Coach
  module BodyStatsProcessor
    def self.calculate_body_fat_percentage(weight, body_fat_mass)
      (body_fat_mass / weight * 100).round(2)
    end

    def self.calculate_fat_percentage(current_weight, body_fat_mass)
      @body_fat_percentage ||= calculate_body_fat_percentage(current_weight, body_fat_mass)
    end

    def self.create_goal(current_weight, body_fat_mass, body_fat_percentage)
      Goal.find_or_create_by(
        weight: current_weight,
        fat_mass: body_fat_mass,
        body_fat_percent: body_fat_percentage,
        created_at: Date.today
      )
    end

    def self.create_weight_entry(current_weight, body_fat_mass)
      Weight.create(weight: current_weight, fat_mass: body_fat_mass, created_at: Date.today)
    end

    def self.set_targets
      targets = Struct.new(:weight, :fat_mass, keyword_init: true)

      print "Enter your target weight in lbs: "
      target_weight = gets.chomp.to_f
      
      print "Enter your target body fat mass in lbs: "
      target_fat_mass = gets.chomp.to_f

      targets.new(weight: target_weight, fat_mass: target_fat_mass)
    end

    def self.goal_text(goal)
      <<~TEXT
        Current Goal:
        - Weight: #{goal.weight} lbs
        - Fat Mass: #{goal.fat_mass} lbs
        - Body Fat Percentage: #{calculate_fat_percentage(goal.weight, goal.fat_mass)}%
      TEXT
    end

    def self.goal_summary(current_goal)
      puts goal_text(current_goal)

      print "Would you like to set a new goal? (y/n): "
      answer = gets.chomp.downcase

      if answer.match?(/^y(es)?$/)
        set_a_new_goal
      else
        puts "Continuing with current goal."
      end
    end

    def self.set_a_new_goal
      targets = set_targets

      target_body_fat_percentage = calculate_fat_percentage(targets.weight, targets.fat_mass)

      goal = create_goal(targets.weight, targets.fat_mass, target_body_fat_percentage)

      puts goal_text(goal)
    end

    def self.process
      print "Enter your current weight in lbs: "
      current_weight = gets.chomp.to_f
      
      print "Enter your current body fat mass lbs: "
      body_fat_mass = gets.chomp.to_f

      fat_percentage = calculate_fat_percentage(current_weight, body_fat_mass)

      create_weight_entry(current_weight, body_fat_mass)
      
      current_goal = Goal.last

      if current_goal
        goal_summary(current_goal)
      else
        puts "No current goal found. Let's set a new goal!"
        set_a_new_goal
      end

      current_goal = Goal.last if current_goal != Goal.last

      calculator = Calculator.new(current_weight, fat_percentage)
      muscle_mass = calculator.calculate_muscle_mass
      muscle_percentage = calculator.calculate_muscle_percentage
      fat_mass = calculator.calculate_fat_mass
      
      Weight.last.update(
        muscle_mass: muscle_mass,
        muscle_percentage: muscle_percentage,
        fat_percentage: fat_percentage
      )

      prompt = PromptBuilder.build_body_stats_prompt(
        current_weight,
        fat_mass,
        fat_percentage,
        muscle_mass,
        muscle_percentage
      )
      
      analyzer = Analyzer.new(prompt)
      analysis = analyzer.analyze_data
      
      parsed_analysis = JsonParser.parse(analysis, validation_type: :body_stats)
      
      if parsed_analysis.nil?
        puts "Error: Unable to parse analysis response."
        exit(1)
      end

      current_goal.update(
        calories: parsed_analysis['macro_goals']['calories'],
        carbs: parsed_analysis['macro_goals']['carbs'],
        fats: parsed_analysis['macro_goals']['fats'],
        protein: parsed_analysis['macro_goals']['protein']
      )
      
      BodyStatsSummary.display_body_stats_summary(parsed_analysis)
    end
  end
end
