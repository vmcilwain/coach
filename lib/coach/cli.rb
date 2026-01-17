module Coach
  module CLI
    def self.start
      puts "\n"
      puts "="*80
      puts "BODYBUILDING COACH"
      puts "="*80
      puts "\n"
      
      puts "What would you like to do?"
      puts "  1. Enter body stats"
      puts "  2. Log meals"
      puts "\n"
      
      print "Choose (1 or 2): "
      choice = gets.chomp
      
      case choice
      when '1'
        BodyStatsProcessor.process
      when '2'
        MealProcessor.process
      else
        puts "Invalid choice. Please run again and choose 1 or 2."
      end
    end
  end
end
