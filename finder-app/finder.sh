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

countfiles=$(find $filesdir -type f | wc -l)
matchinglines=$(grep -r $searchstr $filesdir | wc -l)

echo "The number of files are $countfiles and the number of matching lines are $matchinglines"

exit 0
