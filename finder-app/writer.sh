#!/bin/bash

if [ $# -ne 2 ]; then
    >&2 echo "invocation of script should be: 'writer.sh WRITEFILE WRITESTR'"
    exit 1
fi

writefile=$1
writestr=$2

if [ -z $writefile ] || [ -z $writestr ]; then
    >&2 echo "input arguments cannot be empty"
    exit 1
fi

if [ -d $writefile ]; then
    echo "provided file is an existing directory"
    exit 1
fi

dirstr=$(dirname $writefile)
filestr=$(basename $writefile)


if [ -f $dirstr ]; then
    echo "provided directory is an existing file"
    exit 1
fi

if [ -z $filestr ]; then
    echo "write path must contain filename"
    exit 1
fi

if [ ! -d $dirstr ]; then
    mkdir -p $dirstr
    if [ ! -d $dirstr ]; then
        echo "creation of directory '$dirstr' failed"
        exit 1
    fi
fi

if [ ! -f $writefile ]; then
    touch $writefile
    if [ ! -f $writefile ]; then
        echo "creation of file '$writefile' failed"
        exit 1
    fi
fi

echo $writestr > $writefile

exit 0
