#!/usr/bin/env bash
# Project-local deep-tutor completion gate for this repository's nested layout:
#   *-notes/part-*/chapter-*/*.md
#
# Supports both Claude Code Write/Edit events (tool_input.file_path) and
# Codex apply_patch events (tool_input.command). JSON is received on stdin.

set -uo pipefail

export LC_ALL=C

input=$(cat)

resolve_checker() {
  for candidate in \
    "${HOME}/.claude/skills/deep-tutor/scripts/check-note.sh" \
    "${HOME}/.agents/skills/deep-tutor/scripts/check-note.sh" \
    "${CODEX_HOME:-${HOME}/.codex}/skills/deep-tutor/scripts/check-note.sh"
  do
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

checker=$(resolve_checker) || exit 0

extract_paths() {
  python3 -c '
import json
import os
import re
import sys

try:
    event = json.load(sys.stdin)
except (json.JSONDecodeError, TypeError, ValueError):
    raise SystemExit(0)

tool_input = event.get("tool_input")
if not isinstance(tool_input, dict):
    raise SystemExit(0)

raw_paths = []

file_path = tool_input.get("file_path")
if isinstance(file_path, str) and file_path:
    raw_paths.append(file_path)

command = tool_input.get("command")
if isinstance(command, str):
    for line in command.splitlines():
        match = re.match(r"^\*\*\* (?:Add|Update|Delete) File: (.+)$", line)
        if match:
            raw_paths.append(match.group(1))
            continue
        match = re.match(r"^\*\*\* Move to: (.+)$", line)
        if match:
            raw_paths.append(match.group(1))

cwd = event.get("cwd")
if not isinstance(cwd, str) or not cwd:
    cwd = os.getcwd()

seen = set()
for path in raw_paths:
    path = os.path.expanduser(path)
    if not os.path.isabs(path):
        path = os.path.normpath(os.path.join(cwd, path))
    if path not in seen:
        seen.add(path)
        print(path)
'
}

if ! command -v python3 >/dev/null 2>&1; then
  # Claude Code installations supported by this project run on a machine with
  # Python 3. If it disappears, do not break unrelated file edits.
  exit 0
fi

paths=$(printf '%s' "$input" | extract_paths)
[ -z "$paths" ] && exit 0

is_concept_note() {
  file_path=$1
  file_name=${file_path##*/}
  chapter_dir=${file_path%/*}
  chapter_name=${chapter_dir##*/}
  part_dir=${chapter_dir%/*}
  part_name=${part_dir##*/}
  notes_dir=${part_dir%/*}
  notes_name=${notes_dir##*/}

  case "$file_name" in
    _*|*.md) ;;
    *) return 1 ;;
  esac

  case "$file_name" in
    _*) return 1 ;;
  esac

  case "$chapter_name" in
    chapter-*) ;;
    *) return 1 ;;
  esac

  case "$part_name" in
    part-*) ;;
    *) return 1 ;;
  esac

  case "$notes_name" in
    *-notes) return 0 ;;
    *) return 1 ;;
  esac
}

failed=0
while IFS= read -r file_path; do
  [ -z "$file_path" ] && continue
  [ -f "$file_path" ] || continue
  is_concept_note "$file_path" || continue

  if output=$("$checker" "$file_path" 2>&1); then
    continue
  fi

  printf 'deep-tutor 완료 게이트 실패 (%s) — 아래를 고친 뒤 다시 저장하세요.\n%s\n' \
    "$file_path" "$output" >&2
  failed=1
done <<EOF
$paths
EOF

[ "$failed" -eq 0 ] || exit 2
exit 0
