#!/usr/bin/env bash

set -eEuo pipefail

trap 'printf "\n\e[31mError: Exit Status %s (%s)\e[m\n" $? "$(basename "$0")"' ERR

cd "$(dirname "$0")"

echo
echo "Start ($(basename "$0"))"

shopt -s nullglob

rm -f {.,*}/*.gem

./package.sh

echo
echo "Publishing"
echo "= = ="

for gem in {.,*}/*.gem; do
  echo
  gem push --key github --host https://rubygems.pkg.github.com/wsgr-neuron "$gem" || true
done

echo
echo "Done ($(basename "$0"))"
