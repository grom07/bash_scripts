#!/usr/bin/env bash
# upgrade: interactive apt maintenance for Debian-based systems

set -Eeuo pipefail

# Privilege helper
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

# Colours, only when on a TTY
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
  YELLOW=$(tput setaf 3 || true)
  RED=$(tput bold; tput setaf 1 || true)
  GREEN=$(tput bold; tput setaf 2 || true)
  RESET=$(tput sgr0 || true)
else
  YELLOW=""; RED=""; GREEN=""; RESET=""
fi
trap 'printf "%s" "$RESET" >/dev/null 2>&1 || true' EXIT

msg() { printf "%b%s%b\n" "$1" "$2" "$RESET"; }

msg "$YELLOW" "Refreshing package lists…"
$SUDO apt update

msg "$YELLOW" "Applying full upgrade…"
$SUDO apt -y full-upgrade

msg "$YELLOW" "Removing unused packages…"
$SUDO apt -y autoremove

msg "$YELLOW" "Cleaning local package cache…"
$SUDO apt -y autoclean

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
  msg "$GREEN" "No reboot required. Have a good day $(printf '\U1F600')"
fi
