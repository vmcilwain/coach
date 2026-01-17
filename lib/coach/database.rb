require 'active_record'
require 'fileutils'

module Coach
  module Database
    def self.data_directory
      @data_directory ||= File.expand_path('~/.coach')
    end

    def self.ensure_data_directory
      FileUtils.mkdir_p(data_directory) unless Dir.exist?(data_directory)
      FileUtils.mkdir_p(File.join(data_directory, 'backups')) unless Dir.exist?(File.join(data_directory, 'backups'))
    end

    def self.database_path(env = nil)
      env ||= ENV.fetch('RAILS_ENV', 'production')
      
      if env == 'production'
        File.join(data_directory, "coach_#{env}.sqlite3")
      else
        # Development and test databases stay in the gem directory
        File.join('db', "coach_#{env}.sqlite3")
      end
    end

    def self.establish_connection(env = nil)
      env ||= ENV.fetch('RAILS_ENV', 'production')
      
      # Only ensure directory exists for production
      ensure_data_directory if env == 'production'
      
      ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: database_path(env)
      )
    end
  end
end
