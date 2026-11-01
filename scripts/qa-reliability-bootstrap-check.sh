#!/usr/bin/env bash
# Non-interactive pre–Pass 1 bootstrap probe for QA Reliability Loop.
# Exit 0 only when frontend, backend, and portal start paths are discoverable.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0
note() { printf '%s\n' "$*"; }
missing() { note "MISSING: $1"; fail=1; }
found() { note "OK: $1"; }

note "=== photobooth-os QA bootstrap check ==="
note "Repo root: $ROOT"
note ""

# Manifests
for f in package.json pnpm-workspace.yaml docker-compose.yml docker-compose.yaml Makefile; do
  if [[ -f "$f" ]]; then found "$f"; else missing "$f (optional bootstrap artifact)"; fi
done

# Common layer directories
for d in frontend backend portal apps/web apps/api apps/portal packages; do
  if [[ -d "$d" ]]; then found "directory $d/"; fi
done

# Docs
if [[ -f README.md ]] && grep -qiE 'start|dev|portal|backend|frontend|docker' README.md 2>/dev/null; then
  found "README.md contains bootstrap keywords"
else
  missing "README.md bootstrap instructions (ports, env, start commands)"
fi

[[ -f AGENTS.md ]] && found "AGENTS.md" || missing "AGENTS.md (recommended for agents)"

# Dev commands
if [[ -f package.json ]]; then
  if command -v npm >/dev/null 2>&1; then
    note ""
    note "npm scripts:"
    node -e "const p=require('./package.json'); console.log(Object.keys(p.scripts||{}).join(', ')||'(none)')"
  fi
else
  missing "package.json — cannot run npm run dev / test"
fi

note ""
if [[ "$fail" -ne 0 ]]; then
  note "RESULT: bootstrap INCOMPLETE — log critical gaps and continue Pass 1 inventory."
  note "Next: run Cursor command .cursor/commands/qa-reliability-10-pass.md"
  exit 1
fi

note "RESULT: bootstrap artifacts present — start services and begin Pass 1 route/API inventory."
exit 0
