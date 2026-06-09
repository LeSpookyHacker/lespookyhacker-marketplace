#!/usr/bin/env bash
# cyberpunk-noir SessionStart greeting ⚡
# Claude Code pipes the session JSON in on stdin; for SessionStart the script's
# STDOUT is shown to Claude at the start of the conversation. We boot the session
# with the signature line. Pure bash — no python, no deps — so the wake-up never
# fails to fire.
#
# Required invariant: every session must open with the exact line
#   Wake up Samurai. We got a city to burn.

# Drain stdin (the session JSON) so the pipe closes cleanly; we don't need it.
cat >/dev/null 2>&1

# --- neon-noir 256-color palette ---
CYAN=$'\033[38;5;51m'    # neon cyan
MAG=$'\033[38;5;201m'    # hot magenta
AMBER=$'\033[38;5;214m'  # amber
DIM=$'\033[38;5;240m'    # grey
BOLD=$'\033[1m'
R=$'\033[0m'

# Fall back to no-color if stdout isn't a terminal AND NO_COLOR is set.
if [ -n "${NO_COLOR:-}" ]; then
  CYAN=""; MAG=""; AMBER=""; DIM=""; BOLD=""; R=""
fi

printf '%s\n' "${DIM}▓▒░ ${CYAN}JACKING IN${DIM} ░▒▓${R}"
printf '%s\n' "${MAG}[ S Y S T E M . B R E A C H ]${R} ${DIM}// night city online${R}"
printf '%s\n' "${BOLD}${AMBER}Wake up Samurai. We got a city to burn.${R}"
