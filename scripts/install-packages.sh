#!/usr/bin/env bash
# Install a basic set of CLI packages on Debian/Ubuntu (apt) or Fedora/RHEL (dnf).
# Usage: bash ~/.dotfiles/scripts/install-packages.sh
set -u

if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

if command -v apt-get >/dev/null 2>&1; then
    PM="apt"
    PACKAGES=(
        # core
        python3 python3-pip python3-venv tree sl git curl wget
        # cli utilities
        htop unzip zip jq nano vim bash-completion ca-certificates
        # network
        iproute2 net-tools dnsutils rsync
        # clipboard
        wl-clipboard xclip
    )
    install_cmd() { $SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"; }
    echo "[+] Updating apt package index..."
    $SUDO apt-get update
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
    PACKAGES=(
        # core (venv ships with python3 on Fedora)
        python3 python3-pip tree sl git curl wget
        # cli utilities
        htop unzip zip jq nano vim-enhanced bash-completion ca-certificates
        # network
        iproute net-tools bind-utils rsync
        # clipboard
        wl-clipboard xclip
    )
    install_cmd() { $SUDO dnf install -y "$@"; }
else
    echo "[!] Unsupported system: neither apt-get nor dnf found." >&2
    exit 1
fi

echo "[+] Installing basic packages with $PM: ${PACKAGES[*]}"
if install_cmd "${PACKAGES[@]}"; then
    echo "[ok] All basic packages installed"
    exit 0
fi

# Batch failed (usually one unavailable package) - retry one by one
echo "[!] Batch install failed, retrying packages individually..."
failed=()
for pkg in "${PACKAGES[@]}"; do
    install_cmd "$pkg" >/dev/null 2>&1 || failed+=("$pkg")
done

if [ ${#failed[@]} -eq 0 ]; then
    echo "[ok] All basic packages installed"
else
    echo "[!] Could not install: ${failed[*]}" >&2
    exit 1
fi
