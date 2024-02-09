#!/usr/bin/env bash

set -eEuo pipefail

trap 'printf "\n\e[31mError: Exit Status %s (%s)\e[m\n" $? "$(basename "$0")"' ERR

cd "$(dirname "$0")"

echo
echo "Start ($(basename "$0"))"
echo

ruby --version

echo
echo "Run Tests"
echo "= = ="

rspec=${RSPEC:-on}
if [ $rspec = "on" ]; then
  bundle exec rspec
fi

if [ -f test/automated.rb ]; then
  echo

  ruby test/automated.rb
fi

echo "Done ($(basename "$0"))"
