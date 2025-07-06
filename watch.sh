#!/usr/bin/env bash
# Starts the project with automatic rebuild + browser live-reload.
#
# Requires one of:
#   1. haxe-watchify (npm install -g haxe-watchify) – best experience, or
#   2. fswatch + livereloadx (brew install fswatch && npm install -g livereloadx)
#
# Usage:
#   ./watch.sh             # auto rebuild + live refresh
#   ./watch.sh --once      # one-off build (same as start.sh)
#   ./watch.sh --help      # show help

set -euo pipefail

show_help() {
  echo "Usage: $0 [--once] [additional openfl args...]"
  echo "  --once   Perform a single build & run (delegates to start.sh)"
  exit 0
}

if [[ "${1:-}" == "--help" ]]; then show_help; fi
if [[ "${1:-}" == "--once" ]]; then shift; exec ./start.sh "$@"; fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
export HAXE_STD_PATH="${HAXE_STD_PATH:-/opt/homebrew/lib/haxe/std}"

# Detect haxe-watchify
if command -v haxe-watchify >/dev/null 2>&1; then
  echo "[watch] Using haxe-watchify for incremental builds + LiveReload"
  haxe-watchify \
    --program openfl \
    --buildType test \
    --src Source \
    --livereload Export/html5/bin \
    --platforms html5 "$@"
  exit $?
fi

# Fallback to fswatch + livereloadx
if ! command -v fswatch >/dev/null 2>&1; then
  echo "[watch] fswatch not found. Install with 'brew install fswatch' or add haxe-watchify."
  exit 1
fi
if ! command -v livereloadx >/dev/null 2>&1; then
  echo "[watch] livereloadx not found. Install with 'npm install -g livereloadx' or add haxe-watchify."
  exit 1
fi

openfl build html5 -Dcanvas "$@"
(
  cd Export/html5/bin
  livereloadx -s . &
)

echo "[watch] Watching Source/ for changes..."
fswatch -o Source | while read -r; do
  echo "[watch] Rebuilding..."
  openfl build html5 -Dcanvas "$@"
  echo "[watch] Rebuild complete."
done 