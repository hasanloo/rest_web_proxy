#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e


echo "\n Preparing Dependencies"
# Ensure the app's dependencies are installed
mix deps.get

echo "\n Preparing Database migrations"
# Potentially Set up the database
mix ecto.create
mix ecto.migrate

echo "\n Launching Phoenix web server..."
# Start the phoenix web server
mix phx.server
