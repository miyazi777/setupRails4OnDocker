#!/bin/bash

docker build -t rails .
docker-compose run web bundle install
docker-compose run web bundle exec rails new . --force --database=mysql --skip-bundle

echo "gem 'therubyracer', platforms: :ruby" >> Gemfile

docker-compose run web bundle install
mv database.yml config/. 
docker-compose up -d
docker-compose run web bundle exec rake db:create
