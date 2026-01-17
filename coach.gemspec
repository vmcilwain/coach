require_relative 'lib/coach/version'

Gem::Specification.new do |spec|
  spec.name          = "coach"
  spec.version       = Coach::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]

  spec.summary       = "Bodybuilding coach assistant powered by AI"
  spec.description   = "A command-line tool that provides bodybuilding coaching advice, meal tracking, and macro goal management using AI analysis"
  spec.homepage      = "https://github.com/yourusername/coach"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.files         = Dir["lib/**/*", "db/**/*", "bin/*", "README.md", "LICENSE.txt", "Rakefile", ".standalone_migrations"]
  spec.bindir        = "bin"
  spec.executables   = ["coach", "coach-db"]
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_dependency "sqlite3"
  spec.add_dependency "ruby_llm"
  spec.add_dependency "standalone_migrations"
  spec.add_dependency "bigdecimal"
  spec.add_dependency "mutex_m"

  spec.add_development_dependency "rspec", "~> 3.0"
end
