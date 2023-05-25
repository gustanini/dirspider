# /bin/bash

# Dependencies: gospider, dirsearch
# sudo apt install gospider
# sudo apt install dirsearch

# This bash script runs dirsearch on selected URL, passes it's output to gospider for crawling. 
# Useful for thorough HTTP enumeration. If deeper enumeration is needed flag '-r' can be specified for recursion.
# Github: https://github.com/gustanini

function dirspider()
{
# Parse command-line args
URL=$1
recursive=false
help=false

# read flags
if [[ $# -gt 1 ]]; then
  help=true
elif [[ $1 == "-h" ]]; then
  help=true
elif [[ $2 == "-h" ]]; then
  help=true
elif [[ $2 == "-f" ]]; then
  recursive=true
fi

# add instructions (use flag -h for help, -r is for recursion, This script takes in one mandatory argument URL and an optional flag -r for recursion)
if [[ $help == true ]]; then
  echo "Usage: $0 <URL> [-f]"
  echo "-h: Show this help message"
  echo "-f: Enable recursion"
  exit 0
fi

# recursive loop  
if [ recursive == true ]
then
    dirsearch -u $1 -r --deep-recursive -F -t 100 -x 404,400,500 "$(pwd)/dirsearch.out" --format=simple && gospider -S dirsearch.out -d 2 -t 50 > spider.out
    echo "Results on dirsearch.out and spider.out"
    exit 0
fi

# non recursive loop
if [ $# -lt 1 ]
then
    # Run dirsearch no recursion
    dirsearch -u $1 -F -t 100 -x 404,400,500 "$(pwd)/dirsearch.out" --format=simple && gospider -S dirsearch.out -d 2 -t 50 > spider.out
    echo "Results on dirsearch.out and spider.out"
    exit 0
fi
}