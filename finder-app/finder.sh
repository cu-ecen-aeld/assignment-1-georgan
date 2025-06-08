#!/bin/bash

if [ $# -ne 2 ]; then
    >&2 echo "invocation of script should be: 'finder.sh FILESDIR SEARCHSTR'"
    exit 1
fi

filesdir=$1
searchstr=$2

if [ -z $filesdir ] || [ -z $searchstr ]; then
    >&2 echo "input arguments cannot be empty"
    exit 1
fi

if [ ! -d $filesdir ]; then
    >&2 echo "$filesdir is not a valid directory on the filesystem"
    exit 1
fi

tempfile=$(mktemp)

grep -rch $searchstr $filesdir > $tempfile

matchingfiles=$(cat $tempfile | awk '$1>0 {print $1; }'| wc -l)
matchinglines=$(cat $tempfile | awk '{ SUM += $1} END { print SUM }')

echo "The number of files are $matchingfiles and the number of matching lines are $matchinglines"

rm $tempfile

exit 0
