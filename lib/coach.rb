require 'active_record'
require 'date'
require 'json'

require_relative 'coach/version'
require_relative 'coach/database'
require_relative 'coach/models/goal'
require_relative 'coach/models/weight'
require_relative 'coach/models/meal'
require_relative 'coach/calculator'
require_relative 'coach/analyzer'
require_relative 'coach/json_parser'
require_relative 'coach/body_stats_summary'
require_relative 'coach/meal_summary'
require_relative 'coach/prompt_builder'
require_relative 'coach/meal_processor'
require_relative 'coach/body_stats_processor'
require_relative 'coach/cli'

module Coach
end
