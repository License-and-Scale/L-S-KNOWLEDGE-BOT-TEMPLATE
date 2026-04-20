#!/usr/bin/env bash
# =============================================================================
# render-config.sh — Substitute ${ENV_VAR} placeholders in a template
#
# Usage:
#   ./scripts/render-config.sh profiles/coo/openclaw.json.template > openclaw.json
#
# Reads env vars from:
#   1. The current shell environment
#   2. A .env file in the current directory (if present)
#
# Fails loudly if any required variable is unset.
# =============================================================================
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <template-file>" >&2
    exit 1
fi

TEMPLATE="$1"
if [[ ! -f "$TEMPLATE" ]]; then
    echo "Template not found: $TEMPLATE" >&2
    exit 1
fi

# Load .env if present
if [[ -f .env ]]; then
    set -a
    # shellcheck disable=SC1091
    source .env
    set +a
fi

# Collect every ${VAR} reference in the template
MISSING=()
while IFS= read -r var; do
    if [[ -z "${!var:-}" ]]; then
        MISSING+=("$var")
    fi
done < <(grep -oE '\$\{[A-Z_][A-Z0-9_]*\}' "$TEMPLATE" | tr -d '${}' | sort -u)

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "Missing required env vars:" >&2
    printf '  - %s\n' "${MISSING[@]}" >&2
    echo "" >&2
    echo "Set them in your shell or a .env file and re-run." >&2
    exit 1
fi

envsubst < "$TEMPLATE"
