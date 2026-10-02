#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Checking if Antigravity is running..."
if pgrep -ix "Antigravity" >/dev/null 2>&1 || pgrep -f "Antigravity.app/Contents/MacOS/Antigravity" >/dev/null 2>&1; then
  echo "==> Closing Antigravity gracefully..."
  osascript -e 'tell application "Antigravity" to quit' >/dev/null 2>&1 || true
  sleep 2
  # If still running, force terminate
  if pgrep -ix "Antigravity" >/dev/null 2>&1; then
    pkill -ix "Antigravity" >/dev/null 2>&1 || true
    sleep 1
  fi
fi

echo "==> Applying patch..."
node "$SCRIPT_DIR/scripts/deploy.mjs" "$@"

echo "==> Re-opening Antigravity..."
if [ -d "/Applications/Antigravity.app" ]; then
  open "/Applications/Antigravity.app" || true
elif [ -d "$HOME/Applications/Antigravity.app" ]; then
  open "$HOME/Applications/Antigravity.app" || true
fi

echo "==> Done! Patch applied successfully."
