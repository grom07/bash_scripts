#!/usr/bin/env bash
# Grom’s System Update Utility v1.2
# Interactive upgrade script for Debian-based systems (uses apt)
# Clean obsolete cached packages with: upgrade --clean

set -Eeuo pipefail

# -------- options --------
DO_CLEAN=false
for arg in "$@"; do
  case "$arg" in
    --clean|--autoclean) DO_CLEAN=true ;;
    *) printf "Unknown option: %s\n" "$arg" >&2; exit 2 ;;
  esac
done

# -------- privilege helper --------
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

# -------- colours --------
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
  YELLOW=$(tput setaf 3 || true)
  RED=$(tput bold; tput setaf 1 || true)
  GREEN=$(tput bold; tput setaf 2 || true)
  BLUE=$(tput bold; tput setaf 4 || true)
  RESET=$(tput sgr0 || true)
else
  YELLOW=""; RED=""; GREEN=""; BLUE=""; RESET=""
fi
trap 'printf "%s" "$RESET" >/dev/null 2>&1 || true' EXIT

msg() { printf "%b%s%b\n" "$1" "$2" "$RESET"; }

# -------- banner --------
if [[ -t 1 ]]; then
  printf "%b%s%b\n" "$BLUE" "────────────────────────────────────────────────────────" "$RESET"
  printf "%b%s%b\n" "$BLUE" "   Grom’s System Update Utility v1.2" "$RESET"
  printf "%b%s%b\n\n" "$BLUE" "────────────────────────────────────────────────────────" "$RESET"
fi

# -------- main --------
msg "$YELLOW" "Refreshing package lists…"
$SUDO apt update

msg "$YELLOW" "Applying full upgrade…"
$SUDO apt -y full-upgrade

msg "$YELLOW" "Removing unused packages…"
$SUDO apt -y autoremove

if $DO_CLEAN; then
  msg "$YELLOW" "Cleaning obsolete package cache…"
  $SUDO apt -y autoclean
fi

# -------- reboot handling --------
REBOOT_FLAG="/var/run/reboot-required"
if [[ -f "$REBOOT_FLAG" ]]; then
  msg "$RED" "Reboot required."
  if [[ -t 0 ]]; then
    printf "Reboot now? [y/N]: "
    read -r ans
    [[ "${ans,,}" =~ ^y(es)?$ ]] && exec $SUDO reboot now
  else
    msg "$YELLOW" "Non-interactive session detected, please reboot when convenient."
  fi
else
  printf "%bNo reboot required.%b\n" "$GREEN" "$RESET"
  printf "%bHave a good day %b\U1F600%b\n\n" "$GREEN" "$YELLOW" "$RESET"   # 😀 in yellow
fi
