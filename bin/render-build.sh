#!/bin/bash
set -o errexit  # エラーが発生した場合にスクリプトを停止

# Bundle install to install all required gems
bundle install

# Database migrations
bundle exec rails db:migrate

# Precompile assets
bundle exec rails assets:precompile

# Clean old assets
bundle exec rails assets:clean
