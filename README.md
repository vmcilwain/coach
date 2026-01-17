# Coach

A bodybuilding coach assistant powered by AI that provides personalized coaching advice, meal tracking, and macro goal management.

## Features

- **Body Composition Analysis**: Track weight, body fat, and muscle mass with AI-powered coaching recommendations
- **Meal Tracking**: Log meals and get nutrition analysis against your macro goals
- **Macro Goal Management**: Automatically calculated macro goals based on your body composition
- **AI-Powered Coaching**: Get personalized advice from an AI trained to provide bodybuilding coaching

## Installation

### Requirements

- Ruby >= 3.4.0
- Ollama running locally with `llama3.1:8b` model (for AI features)
- Set `RAILS_ENV ['development', 'test', or 'production']. Defaults to `production` if not set

```bash
export RAILS_ENV=development
```

### Development Setup

1. Clone the repository
2. Install dependencies:

```bash
bundle install
```

3. Run database setup:

```bash
bin/coach-db setup
```

4. Run the coach assistant:

```bash
bin/coach
```

5. Build the gem (optional)

```bash
gem build coach.gemspec
```

### Console

To open an IRB console with the Coach library loaded:

```bash
bundle exec rake console
```

### As a built gem

1. Install the gem locally

```bash

gem install coach-0.1.0.gem
```

2. Run initial database setup (first time only):

```bash
coach-db setup
```

3. Run the coach assistant:

```bash
coach
```

## Database Management

**Database Location:** `~/.coach/coach_production.sqlite3`

**Backups Location:** `~/.coach/backups/`

### Development

This gem uses the [standalone_migrations](https://github.com/thuss/standalone-migrations) gem for managaing the database.

Use the following commands in development/test or use the `bin/coach-db` executable for convenience

```bash
# These run against production by default
bundle exec rake db:migrate                      # Run migrations
bundle exec rake db:migrate:status               # Show migration status
bundle exec rake db:rollback                     # Rollback last migration
bundle exec rake db:rollback STEP=3              # Rollback last 3 migrations
bundle exec rake "db:new_migration[name]"        # Create new migration
bundle exec rake db:create                       # Create database
bundle exec rake db:drop                         # Drop database
```

### As a built gem

When installed as a gem, use the `coach-db` command to manage the database:

```bash
# Show migration status
coach-db status

# Run pending migrations (after gem updates)
coach-db migrate

# Rollback last migration
coach-db rollback

# Rollback multiple migrations
coach-db rollback 3

# Backup your database
coach-db backup

# Show all available commands
coach-db help
```

## License

MIT

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
