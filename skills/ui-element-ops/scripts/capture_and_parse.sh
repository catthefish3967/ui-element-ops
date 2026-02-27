#!/usr/bin/env bash
set -euo pipefail

# Capture a screenshot and parse it with randomized file names.
#
# Usage:
#   capture_and_parse.sh [--dry-run] [output_dir] [prefix]
#
# Examples:
#   skills/ui-element-ops/scripts/capture_and_parse.sh
#   skills/ui-element-ops/scripts/capture_and_parse.sh /tmp ui
#   skills/ui-element-ops/scripts/capture_and_parse.sh --dry-run /tmp ui
#
# Env (optional):
#   VENV_PATH: Python venv path (default: $PWD/.venv)
#   OMNIPARSER_DIR: OmniParser repo path (default: /tmp/OmniParser)
#   TYPE_RULES: type rules json path

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=1
  shift
fi

OUTPUT_DIR="${1:-/tmp}"
PREFIX="${2:-ui}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v uuidgen >/dev/null 2>&1; then
  RAND="$(uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '-' | cut -c1-8)"
else
  RAND="$(LC_ALL=C tr -dc 'a-f0-9' </dev/urandom | head -c8)"
fi

ID="$(date +%Y%m%d-%H%M%S)-${RAND}"
BASE="${OUTPUT_DIR%/}/${PREFIX}-${ID}"
IMG="${BASE}.png"
JSON="${BASE}.elements.json"
OVERLAY="${BASE}.overlay.png"

mkdir -p "$OUTPUT_DIR"

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] screenshot: $IMG"
  echo "[dry-run] elements:   $JSON"
  echo "[dry-run] overlay:    $OVERLAY"
  exit 0
fi

python3 "$SCRIPT_DIR/operate_ui.py" screenshot --output "$IMG"
"$SCRIPT_DIR/run_parse_ui.sh" "$IMG" "$JSON" "$OVERLAY"

echo "screenshot: $IMG"
echo "elements:   $JSON"
echo "overlay:    $OVERLAY"
