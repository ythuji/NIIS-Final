#!/bin/sh
# ----------------------------------------------------------------------------
# Maven Wrapper Startup Script
# ----------------------------------------------------------------------------

set -e

PRG="$0"
while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`"/$link"
  fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

if command -v mvn >/dev/null 2>&1; then
  exec mvn "$@"
else
  echo "Error: mvn command not found on PATH." >&2
  exit 1
fi
