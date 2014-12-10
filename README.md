# Capistrano::Gity

Git deployment helpers for Capistrano v3.

#Installation

Add this in your Gemfile:

```ruby
gem 'capistrano', '~> 3.1'
gem 'capistrano-gity', '~> 1.0.2'
```

# Usage

Require in `Capfile` to use gity as a wrapper of capistrano:deploy task:

```ruby
require 'capistrano/gity'
```

The task `gity:prepare_deploy` runs before `deploy:starting` and creates a remote temp branch under `remote/deploy/`.

Use the following to delete the temporary branch after successfull deployment,
i.e. after `deploy:finished`:

```ruby
set :auto_cleanup, true
```

You can also change the default temporary branch prefix, i.e. `deploy/` with:

```ruby
set :branch_prefix, 'deploy/production/'
```

# Useful tasks

```sh
bundle exec cap production gity:help
bundle exec cap production gity:check
bundle exec cap production gity:uptip
bundle exec cap production gity:cleanup_temp_branches
```

Check the module for details :)

## Contributing

1. Fork the project
2. Make your feature addition or bug fix
3. Create new Pull Request
