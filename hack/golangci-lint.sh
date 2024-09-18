#!/bin/bash
set -e

# appends /... to th end of each token
# e.g. "dir1 dir2" => "dir1/... dir2/..."
append_wildcard_suffixes() {
    local input_list="${1}"
    local result=""

    for token in ${input_list}; do
        result+="${token}/... "
    done
    echo "${result}"
}

source hack/coveredpaths.sh
WILDCARDED_PATHS=$(append_wildcard_suffixes "${COVERED_PATHS}")
golangci-lint run --timeout 20m --verbose ${WILDCARDED_PATHS} && \
golangci-lint run --disable-all -E ginkgolinter --timeout 10m --verbose --no-config \
    ./pkg/... \
    ./tests/...
