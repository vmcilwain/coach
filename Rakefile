require 'fileutils'

# Default to production environment if not set
ENV['RAILS_ENV'] ||= 'production'

require 'standalone_migrations'

# Ensure ~/.coach directory exists for production database
task :ensure_data_directory do
  # Only create directory if running production migrations
  if ENV['RAILS_ENV'] == 'production'
    data_dir = File.expand_path('~/.coach')
    FileUtils.mkdir_p(data_dir) unless Dir.exist?(data_dir)
    FileUtils.mkdir_p(File.join(data_dir, 'backups')) unless Dir.exist?(File.join(data_dir, 'backups'))
  end
end

# Make all db tasks depend on ensure_data_directory
namespace :db do
  task :load_config => :ensure_data_directory
end

StandaloneMigrations::Tasks.load_tasks

require_relative 'lib/coach/version'

task :console do
  require_relative 'lib/coach'
  Coach::Database.establish_connection
  require 'irb'
  ARGV.clear
  IRB.start
end
