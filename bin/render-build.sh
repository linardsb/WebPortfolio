#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

# Use a dummy secret key for asset precompilation
# The real SECRET_KEY_BASE will be used at runtime
SECRET_KEY_BASE=dummy bundle exec rake assets:precompile
bundle exec rake assets:clean

bundle exec rake db:migrate
