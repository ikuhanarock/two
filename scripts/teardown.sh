#!/usr/bin/env bash

set -e

docker-compose run --rm backend bin/rails data:backup
docker-compose down -v --rmi=all