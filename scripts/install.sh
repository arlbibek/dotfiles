#!/usr/bin/env bash
# Usage:
#   curl -fsSL https://bibeka.com.np/install | bash                     # prompts for basic packages (if a terminal is available)
#   curl -fsSL https://bibeka.com.np/install | bash -s -- --packages    # also install basic packages
#   curl -fsSL https://bibeka.com.np/install | bash -s -- --no-packages # skip basic packages
set -e

REPO_URL="https://github.com/arlbibek/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

INSTALL_PACKAGES=""
for arg in "$@"; do
    case "$arg" in
        -p|--packages)    INSTALL_PACKAGES="yes" ;;
        --no-packages)    INSTALL_PACKAGES="no" ;;
        -h|--help)
            echo "Usage: install.sh [--packages | --no-packages]"
            exit 0 ;;
        *) echo "[!] Unknown option: $arg" >&2; exit 1 ;;
    esac
done

if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

echo "[+] Installing dotfiles from $REPO_URL"

# Ensure git exists
if ! command -v git >/dev/null 2>&1; then
    echo "[!] git not found. Installing git..."
    if command -v apt-get >/dev/null 2>&1; then
        $SUDO apt-get update && $SUDO apt-get install -y git
    elif command -v dnf >/dev/null 2>&1; then
        $SUDO dnf install -y git
    else
        echo "[!] Please install git manually and re-run." >&2
        exit 1
    fi
fi

# Clone or update repo
if [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "[+] Cloning dotfiles repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo "[+] Updating existing dotfiles repository..."
    if [ -n "$(git -C "$DOTFILES_DIR" status --porcelain)" ]; then
        echo "[!] Local changes in $DOTFILES_DIR - stashing them before pull"
        git -C "$DOTFILES_DIR" -c user.name=dotfiles -c user.email=dotfiles@localhost \
            stash push -u -m "dotfiles auto-stash $(date '+%F %T')" >/dev/null
        echo "[i] Restore with: git -C $DOTFILES_DIR stash pop   (use ~/.bash_aliases.local for custom aliases)"
    fi
    git -C "$DOTFILES_DIR" pull
fi

# Symlink bash aliases
echo "[+] Linking bash aliases..."
ln -sf "$DOTFILES_DIR/bash/bash_aliases" "$HOME/.bash_aliases"

# Ensure bashrc loads bash_aliases
if ! grep -q "bash_aliases" "$HOME/.bashrc" 2>/dev/null; then
    echo "[+] Enabling ~/.bash_aliases in ~/.bashrc"
    cat <<'EOF' >> "$HOME/.bashrc"

# Load user aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
EOF
fi

# Optional: basic packages (ask via /dev/tty so it works with curl | bash)
if [ -z "$INSTALL_PACKAGES" ] && [ -r /dev/tty ] && { true </dev/tty; } 2>/dev/null; then
    read -r -p "[?] Install basic packages (python3, pip, tree, sl, htop, jq, ...)? [y/N] " reply </dev/tty || reply=""
    case "$reply" in [yY]*) INSTALL_PACKAGES="yes" ;; esac
fi

if [ "$INSTALL_PACKAGES" = "yes" ]; then
    bash "$DOTFILES_DIR/scripts/install-packages.sh" || echo "[!] Some packages failed to install (see above)"
else
    echo "[i] Skipped basic packages. Install later with: install-basics"
fi

echo "[ok] Dotfiles installed successfully"
echo "[i] Open a new terminal or run: source ~/.bash_aliases"
