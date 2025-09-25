#!/bin/sh

set -e

echo "Waiting for database to be ready..."
timeout=30
while ! PGPASSWORD=password pg_isready -h db -p 5432 -U postgres -d rails_app >/dev/null 2>&1; do
  timeout=$((timeout - 1))
  if [ $timeout -eq 0 ]; then
    echo "Database connection timeout"
    exit 1
  fi
  echo "Waiting for database... ($timeout seconds remaining)"
  sleep 2
done

echo "Database is ready!"

bundle exec rails s -b 0.0.0.0
