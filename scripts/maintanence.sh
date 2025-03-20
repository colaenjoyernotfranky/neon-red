#!/bin/bash

LAST_RUN_FILE=~/.config/i3/scripts/logs/maintenance
PROMPT_COLOR='\033[0;34m'
ERROR_COLOR='\033[0;31m'
RESET='\033[0m'


is_installed() {
  pacman -Qq "$1" &> /dev/null
}

if [[ -f "$LAST_RUN_FILE" ]]; then
  LAST_RUN=$(cat "$LAST_RUN_FILE")
  CURRENT_TIME=$(date +%s)

  DIFF=$(( (CURRENT_TIME - LAST_RUN) / 86400))

  if (( DIFF < 7 )); then
    exit 0
  else
    touch "$LAST_RUN_FILE"
    echo "$(date +%s)" > "$LAST_RUN_FILE"
  fi
fi

echo -ne "${PROMPT_COLOR}Running Maintenance Script. Do you want to continue? (y/n)${RESET}"
read ans

if [[ ! "$ans" =~ ^[Yy]$ ]]; then
  echo -e "${ERROR_COLOR}ERROR: Maintenance cancelled.${RESET}"
  exit 1
fi

if [ ! -f /etc/arch-release ]; then
  echo -e "${ERROR_COLOR}ERROR: This script only works on arch-based systems${RESET}"
  exit 1
fi

echo -e "${PROMPT_COLOR}> Updating official packages...${RESET}"
sudo pacman -Syu

if is_installed yay; then
  echo -e "${PROMPT_COLOR}> Updating AUR packages using yay...${RESET}"
  yay -Syu
  echo -e "${PROMPT_COLOR}> Cleaning caches...${RESET}"
  yay -Scc
fi

if is_installed pacman-contrib; then
  echo -e "${PROMPT_COLOR}> Clearing pacman cache...${RESET}"
  paccache -r
fi

echo -e "${PROMPT_COLOR}> Removing orphaned packages...${RESET}"
if [[ -n $(pacman -Qtd) ]]; then
  pacman -Qdtq | sudo pacman -Rns -
else
  echo -e "${PROMPT_COLOR}-> No orphaned packages found.${RESET}"
fi

echo -e "${PROMPT_COLOR}> Pulling .config/i3...${RESET}"
git -C ~/.config/i3 fetch
git -C ~/.config/i3 pull
i3 restart

echo -e "${PROMPT_COLOR}> Checking for failed systemd services...${RESET}"
systemctl --failed

echo -e "${PROMPT_COLOR}> Checking for errors in log files (press Q to exit)...${RESET}"
journalctl --priority=err --boot

echo -e "${PROMPT_COLOR}> Checking for broken symlinks...${RESET}"
syms=$(sudo find / -type d \( -path "/dev" -o -path "/proc" -o -path "/run" -o -path "/sys" \) -prune -o -xtype l -print)

if [ -n "${syms}" ]; then
  count=$(echo -e "${syms}" | wc -l)
  echo -e "${PROMPT_COLOR}> Found ${count} broken symlink(s). Please inspect and remove manually.${RESET}"
  echo -e "${syms}"
else
  echo -e "${PROMPT_COLOR}-> No broken symlinks found.${RESET}"
fi

echo -e "${PROMPT_COLOR}> Maintenance completed.${RESET}"

touch "$LAST_RUN_FILE"
echo "$(date +%s)" > "$LAST_RUN_FILE"

sleep 2
