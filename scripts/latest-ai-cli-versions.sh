#!/usr/bin/env bash
set -euo pipefail

need() {
    if ! command -v "$1" >/dev/null 2>&1; then
        printf 'missing required command: %s\n' "$1" >&2
        exit 1
    fi
}

fetch() {
    curl --fail --silent --show-error --location "$@"
}

need curl
need jq

grok_build_version="$(
    fetch https://x.ai/cli/stable
)"

codex_version="$(
    fetch \
        --header 'Accept: application/vnd.github+json' \
        --header 'X-GitHub-Api-Version: 2022-11-28' \
        https://api.github.com/repos/openai/codex/releases/latest \
        | jq --raw-output '
            if (.name // "") != "" then
                .name
            else
                .tag_name
            end
            | sub("^rust-v"; "")
            | sub("^v"; "")
        '
)"

claude_code_version="$(
    fetch https://registry.npmjs.org/@anthropic-ai/claude-code/latest \
        | jq --raw-output '.version'
)"

printf '%-12s %s\n' grok-build "$grok_build_version"
printf '%-12s %s\n' codex "$codex_version"
printf '%-12s %s\n' claude-code "$claude_code_version"
