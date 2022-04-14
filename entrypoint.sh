#!/bin/bash

detekt_formatting="/opt/detekt-formatting.jar"

# cd or fail
cd "$GITHUB_WORKSPACE" || exit 1
# Fixes https://github.com/reviewdog/reviewdog/issues/1158
git config --global --add safe.directory $GITHUB_WORKSPACE || exit 1

if [ "$INPUT_FAIL_ON_ERROR" = true ] ; then
  set -o pipefail
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

detekt_command="java -jar /opt/detekt.jar "
detekt_command+="--fail-fast "
detekt_command+="--config ${INPUT_DETEKT_CONFIG} "
detekt_command+="--report xml:detekt_report.xml "
detekt_command+="--excludes ${INPUT_DETEKT_EXCLUDES} "

if [ -z "$INPUT_DETEKT_PLUGINS" ]; then
  detekt_command+="--plugins ${detekt_formatting} "
else
  detekt_command+="--plugins ${detekt_formatting},${INPUT_DETEKT_PLUGINS} "
fi

if [ -n "$INPUT_DETEKT_BASELINE" ]; then
  detekt_command+="--baseline ${INPUT_DETEKT_BASELINE} "
fi

if [ -n "$INPUT_DETEKT_PARALLEL" ]; then
  detekt_command+="--parallel "
fi

echo "$detekt_command"
eval "$detekt_command"

reviewdog -f=checkstyle -name="detekt" -reporter="${INPUT_REVIEWDOG_REPORTER}" \
  -level="${INPUT_REVIEWDOG_LEVEL}" -filter-mode="${INPUT_REVIEWDOG_FILTER}" <detekt_report.xml
