#!/usr/bin/env sh

################################################################################
# name: s3dd
# what: enumerates a directory of directories and syncs them to S3 in parallel
# why : because sometimes you need to get a ton of files pushed to s3 in a hurry
################################################################################

################################################################################
# "Be conservative in what you do; be liberal in which you accept from others."
################################################################################

set -e
set -o errexit
set -o errtrace
set -o nounset

################################################################################
# NOT RECOMMENDED TO MODIFY UNLESS YOU KNOW EXACTLY WHAT YOU ARE DOING!
################################################################################

# executable path
VERSION=0.0.1

# executable path
EXE_PATH=$(cd $(dirname $0);pwd)

# (xargs) -P maxprocs
# Parallel mode: run at most maxprocs invocations of utility at once.
MAXPROCS=45

################################################################################
# argument handling
################################################################################

# correct # of arguments?
if (($# != 2)); then
    echo "s3dd version $VERSION"
    echo ""
    echo "Usage  : s3dd <source-path> <s3-bucket>"
    echo "Example: s3dd /tmp/client/logos client-logo-assets-bucket"
    exit 1
fi

################################################################################
# Setup a proper name for the new virtual machine
################################################################################

# name of virtual machine to manage/create
SOURCE_DIRECTORY=$1
TARGET_S3_BUCKET=$2

################################################################################
# check for directory existence
################################################################################

# quit if source directory doesn't exist
if [ ! -d $SOURCE_DIRECTORY ]; then
    echo "Source directory (${SOURCE_DIRECTORY}) does not exist."
    exit 1
fi

################################################################################
# check for s3cmd
################################################################################

declare -x S3CMD_BIN=$(which s3cmd)

if [ -z "$S3CMD_BIN" ]; then
    echo "Unfortunately, we can't continue until the S3cmd binary can be found in your path..."
    exit 1
fi

################################################################################
# check for xargs
################################################################################

declare -x XARGS_BIN=$(which xargs)

if [ -z "$XARGS_BIN" ]; then
    echo "Unfortunately, we can't continue until the xargs binary can be found in your path..."
    exit 1
fi

################################################################################
# check for sort
################################################################################

declare -x SORT_BIN=$(which sort)

if [ -z "$SORT_BIN" ]; then
    echo "Unfortunately, we can't continue until the sort binary can be found in your path..."
    exit 1
fi

################################################################################
# check for grep
################################################################################

declare -x GREP_BIN=$(which grep)

if [ -z "$GREP_BIN" ]; then
    echo "Unfortunately, we can't continue until the grep binary can be found in your path..."
    exit 1
fi

################################################################################
# check for find
################################################################################

declare -x FIND_BIN=$(which find)

if [ -z "$FIND_BIN" ]; then
    echo "Unfortunately, we can't continue until the find binary can be found in your path..."
    exit 1
fi

################################################################################
# check for cut
################################################################################

declare -x CUT_BIN=$(which cut)

if [ -z "$CUT_BIN" ]; then
    echo "Unfortunately, we can't continue until the cut binary can be found in your path..."
    exit 1
fi

################################################################################
# what we came to do...
################################################################################

echo ""
echo "Source Directory : $SOURCE_DIRECTORY"
echo "Target S3 Bucket : $TARGET_S3_BUCKET"
echo "(xargs) flags    : -P${MAXPROCS}"

################################################################################
# report directory stats
################################################################################

LARGE_DIRSIZE=$(du -m $SOURCE_DIRECTORY | sort -nr | sed 1d| head -1 | cut -f1)
LARGE_DIRNAME=$(du -m $SOURCE_DIRECTORY | sort -nr | sed 1d| head -1 | cut -f2)

echo "Largest Directory: ${LARGE_DIRSIZE}MB => ${LARGE_DIRNAME}"

################################################################################
# enumerate directories to figure out which directories to emulate
################################################################################

# pushd $SOURCE_DIRECTORY > /dev/null
# EMULATE_KEYS=$(find . -type d | grep -Pv "[.]thumbs" | cut -d "/" -f 2- | grep -Pv "^[.]" | sort -n)
# popd > /dev/null
# 
# OLDIFS=$IFS
# IFS=$'\n'
# for key in $EMULATE_KEYS
# do
#   echo "${key}"
# done
# IFS=$OLDIFS
# exit

################################################################################
# push to s3
################################################################################

cd $SOURCE_DIRECTORY
time find . -maxdepth 1 | cut -d "/" -f 2 | grep -Pv "^[.]" | sort -n | xargs -I % -L1 -P${MAXPROCS} s3cmd sync --verbose --acl-public %/ s3://$TARGET_S3_BUCKET/%/

echo ""
echo "DONE"

