#!/usr/bin/env bash
set -e

# ========= Colors =========
RED="\033[31m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RESET="\033[0m"
BOLD="\033[1m"

# ========= Config =========
PROXY_URL="https://github.com/renomanzzz/LeaderTermux/raw/refs/heads/main/proxy"
ITEMS_URL="https://github.com/renomanzzz/LeaderTermux/raw/refs/heads/main/items.dat"

PROXY_FILE="proxy"
ITEMS_FILE="items.dat"

# ========= Banner =========
clear
echo -e "${CYAN}${BOLD}"
cat << "EOF"
 _                    _           ____                      
| |    ___  __ _  ___| | ___ _ __|  _ \ _ __ _____  ___   _ 
| |   / _ \/ _` |/ __| |/ _ \ '__| |_) | '__/ _ \ \/ / | | |
| |__|  __/ (_| | (__| |  __/ |  |  __/| | | (_) >  <| |_| |
|_____\___|\__,_|\___|_|\___|_|  |_|   |_|  \___/_/\_\\__, |
                                                       |___/
EOF
echo -e "${RESET}"
sleep 1

# ========= Functions =========
info() {
    echo -e "${CYAN}➜${RESET} $1"
}

ok() {
    echo -e "${GREEN}✔${RESET} $1"
}

warn() {
    echo -e "${YELLOW}⚠${RESET} $1"
}

die() {
    echo -e "${RED}✖${RESET} $1"
    exit 1
}

download() {
    local url=$1
    local out=$2

    info "Downloading ${BOLD}$out${RESET}"
    wget --progress=bar:force:noscroll -O "$out" "$url" || die "Download failed: $out"

    if [ ! -s "$out" ]; then
        die "$out is empty"
    fi

    ok "$out downloaded"
}

# ========= Installer =========
info "Starting installation..."
sleep 0.5

if [ -f "$PROXY_FILE" ]; then
    warn "Old proxy found, removing"
    rm -f "$PROXY_FILE"
    ok "Old proxy removed"
fi

download "$PROXY_URL" "$PROXY_FILE"
download "$ITEMS_URL" "$ITEMS_FILE"

chmod +x "$PROXY_FILE"
ok "Proxy is executable"

echo
echo -e "${GREEN}${BOLD}LeaderProxy Installed Successfully!${RESET}"
echo -e "${CYAN}Run:${RESET} ./proxy"
