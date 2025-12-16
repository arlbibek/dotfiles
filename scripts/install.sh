#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/arlbibek/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "[+] Installing dotfiles from $REPO_URL"

# Ensure git exists
if ! command -v git >/dev/null 2>&1; then
    echo "[!] git not found. Installing git..."
    sudo apt update && sudo apt install -y git
fi

# Clone or update repo
if [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "[+] Cloning dotfiles repository..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
else
    echo "[+] Updating existing dotfiles repository..."
    cd "$DOTFILES_DIR"
    git pull
fi

# Symlink bash aliases
echo "[+] Linking bash aliases..."
ln -sf "$DOTFILES_DIR/bash/bash_aliases" "$HOME/.bash_aliases"

# Ensure bashrc loads bash_aliases
if ! grep -q "bash_aliases" "$HOME/.bashrc"; then
    echo "[+] Enabling ~/.bash_aliases in ~/.bashrc"
    cat <<'EOF' >> "$HOME/.bashrc"

# Load user aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
EOF
fi

# Apply aliases (best effort)
source "$HOME/.bash_aliases" 2>/dev/null || true

echo "[ok] Dotfiles installed successfully"
echo "[i] Open a new terminal or run: source ~/.bash_aliases"
