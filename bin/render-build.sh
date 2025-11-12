#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

# Use a dummy secret key for asset precompilation
# The real SECRET_KEY_BASE will be used at runtime
SECRET_KEY_BASE=dummy bundle exec rake assets:precompile
bundle exec rake assets:clean

# Try to run migrations, but don't fail if database is unreachable during build
# Migrations will run on service start via Procfile if they fail here
bundle exec rake db:migrate || echo "Database migrations skipped (will run on service start)"
