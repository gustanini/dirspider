#!/bin/bash

# Dependencies: gospider, dirsearch
# sudo apt install gospider
# sudo apt install dirsearch

# This bash script runs dirsearch on selected URL, passes its output to gospider for crawling.
# Useful for thorough HTTP enumeration. If deeper enumeration is needed, flag '-r' can be specified for recursion.
# Github: https://github.com/gustanini

dirspider() {
# Parse command-line args
URL=$1
recursive=false
help=false

# Read flags
if [[ $# -gt 2 ]]; then
  help=true
elif [[ $# -lt 1 ]]; then
  help=true
elif [[ "$1" == "-h" ]]; then
  help=true
elif [[ "$2" == "-h" ]]; then
  help=true
elif [[ "$2" == "-r" ]]; then
  recursive=true
fi

# Add instructions (use flag -h for help, -r is for recursion. This script takes in one mandatory argument URL and an optional flag -r for recursion)
if [[ $help == true ]]; then
  echo "Usage: $0 <URL> [-r]"
  echo "-h: Show this help message"
  echo "-r: Enable recursion"
  exit 0
fi

# Recursive loop
if [[ "$recursive" == true ]]; then
  dirsearch -u "$1" -r --deep-recursive -F -t 100 -x 404,400,403,500 -o "$(pwd)/dirsearch.out" --format=simple && gospider -S dirsearch.out -d 2 -t 50 > spider.out
echo "Results on dirsearch.out and spider.out"
exit 0
else
  # Run dirsearch without recursion
  dirsearch -u "$1" -F -t 100 -x 404,400,403,500 -o "$(pwd)/dirsearch.out" --format=simple && gospider -S dirsearch.out -d 2 -t 50 > spider.out
echo "Results on dirsearch.out and spider.out"
exit 0
fi
}
dirspider "$@"
