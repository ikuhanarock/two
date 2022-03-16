#!/usr/bin/env bash

set -e

cd `dirname $0`

bash ./teardown.sh
bash ./setup.sh