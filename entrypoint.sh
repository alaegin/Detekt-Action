# cd or fail
cd "$GITHUB_WORKSPACE" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

detekt --config "${INPUT_DETEKT_CONFIG}" --report=xml \
  | reviewdog -f=checkstyle -name="detekt" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}"
