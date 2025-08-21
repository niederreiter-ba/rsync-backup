#!/bin/bash

set -e # exit on error

ENV_FILE=''
if test "$1"
then
  ENV_FILE="$1"
else
  DEFAULT_ENV_FILE="$( dirname $0 )/backup-settings.env"
  if test -f "$DEFAULT_ENV_FILE"
  then
    ENV_FILE="$DEFAULT_ENV_FILE"
  fi
fi

if test "$ENV_FILE"
then
  source "$ENV_FILE" # BASH syntax file that sets SOURCE= and DESTINATION=
fi

TIMESTAMP=$( date -u --iso-8601=seconds | tr ':' '-' )
rsync -a --log-file="$DESTINATION/$TIMESTAMP.log" --backup --backup-dir="overwritten-$TIMESTAMP" "$SOURCE/" "$DESTINATION/"

