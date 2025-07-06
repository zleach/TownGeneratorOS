#!/usr/bin/env bash
# Simple helper script to build and start the Medieval Fantasy City Generator
#
# Usage:
#   ./start.sh [openfl additional arguments]
#
# The script compiles the project for the HTML5 (canvas) target and launches the
# local development server so the game opens in your browser.
# Any extra arguments you pass will be forwarded to the underlying `openfl test` call.

set -euo pipefail

# Move to repository root (directory containing this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure Haxe standard library path is set (Homebrew default)
export HAXE_STD_PATH="${HAXE_STD_PATH:-/opt/homebrew/lib/haxe/std}"

# Compile and run in HTML5 (canvas) mode
openfl test html5 -Dcanvas --window-size=1024,768 "$@" 