# 🐧 Dotfiles

Uniform Linux terminal configuration for servers and workstations.

Designed for:

- Debian / Ubuntu
- Fedora / RHEL (dnf)
- Proxmox VE
- Docker hosts
- SSH-only servers

## ✨ Features

- Clean bash aliases
- Docker & system helpers
- GitHub-synced configuration
- Safe for public use
- One-command installation
- Optional basic package setup (python3, pip, tree, sl, htop, jq, ...)
- Clipboard helper that works on Wayland, X11 and over SSH

## 🚀 Quick Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/arlbibek/dotfiles/refs/heads/master/scripts/install.sh | bash
```

or,

```bash
curl -fsSL https://bibeka.com.np/install | bash
```

The installer asks whether to install the basic packages. To skip the prompt, pass a flag:

```bash
curl -fsSL https://bibeka.com.np/install | bash -s -- --packages     # install basic packages too
curl -fsSL https://bibeka.com.np/install | bash -s -- --no-packages  # dotfiles only
```

Then open a new terminal or run:

```bash
source ~/.bash_aliases
```

## 🔄 Updating Dotfiles

To update on any machine:

```bash
cd ~/.dotfiles && git pull
```

## 🧩 Local Overrides (Recommended)

```bash
nano ~/.bash_aliases.local
```

This file is sourced automatically if present.

## 📦 Included Aliases

| Alias               | Description                                                     |
| ------------------- | --------------------------------------------------------------- |
| `update-all`        | Full system update & cleanup (apt or dnf), then pull dotfiles   |
| `update-dotfiles`   | Re-run the dotfiles installer                                   |
| `install-basics`    | Install basic packages (apt or dnf)                             |
| `copy <file>...`    | Copy files to the clipboard and print lines/bytes copied        |
| `<cmd> \| copy`     | Copy command output to the clipboard                            |
| `mkcd <dir>`        | Create a directory and `cd` into it                             |
| `mkcompose <dir>`   | Create a directory, `cd` into it and edit `compose.yml`         |
| `dc`                | `docker compose`                                                |
| `dcup`              | Start containers in detached mode                               |
| `dcdown`            | Stop and remove containers                                      |
| `dls`               | List all Docker containers                                      |
| `dclogs`            | Follow Docker Compose logs                                      |
| `dcfr`              | Force-recreate containers                                       |
| `dcupdate`          | Pull images & recreate containers                               |
| `dcls` / `dcps`     | List compose projects / services                                |

### 📋 Clipboard

```bash
copy README.md      # [ok] Copied 81 line(s), 1717 bytes to clipboard
git diff | copy
```

`copy` uses `wl-copy` on Wayland, `xclip`/`xsel` on X11, and falls back to OSC 52 over SSH. OSC 52 needs a terminal that supports it, such as kitty, WezTerm, Alacritty, iTerm2 or Windows Terminal.

### 📦 Basic packages

`install-basics` (or `install.sh --packages`) installs:

- **Core:** python3, python3-pip, python3-venv, tree, sl, git, curl, wget
- **CLI:** htop, unzip, zip, jq, nano, vim, bash-completion, ca-certificates
- **Network:** iproute2, net-tools, dnsutils / bind-utils, rsync
- **Clipboard:** wl-clipboard, xclip

## 📂 Repository Structure

```text
dotfiles/
├── bash/
│   └── bash_aliases
├── scripts/
│   ├── install.sh
│   └── install-packages.sh
└── README.md
```

---

Made with ❤️ by [Bibek Aryal](https://bibeka.com.np/).
