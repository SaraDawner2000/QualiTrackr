#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

# For Ruby on Rails apps uncomment these lines to precompile assets and migrate your database.
bundle exec rake assets:clean
bundle exec rake assets:precompile


bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rake slurp:reset
bundle exec rake slurp:parts
bundle exec rake slurp:subcomponents
bundle exec rake slurp:quality_projects