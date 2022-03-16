#!/usr/bin/env bash

set -e

if [ ! -e .env ]; then
  echo "Create .env file."
  cp example.env .env
fi
docker-compose build
docker-compose run --rm backend bin/setup
docker-compose run --rm backend bin/rails data:restore
docker-compose run --rm frontend yarn install
docker-compose up -d