# 🐧 Dotfiles

Uniform Linux terminal configuration for servers and workstations.

Designed for:

- Debian / Ubuntu
- Proxmox VE
- Docker hosts
- SSH-only servers

## ✨ Features

- Clean bash aliases
- Docker & system helpers
- GitHub-synced configuration
- Safe for public use
- One-command installation

## 🚀 Quick Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/arlbibek/dotfiles/refs/heads/master/scripts/install.sh | bash
```

or,

```bash
curl -fsSL https://bibeka.com.np/install | bash
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

| Alias         | Description                           |
| ------------- | ------------------------------------- |
| `pls`         | Run command with `sudo`               |
| `apt-updater` | Full system update, upgrade & cleanup |
| `mkcd <dir>`  | Create a directory and `cd` into it   |
| `dc`          | `docker compose`                      |
| `dcup`        | Start containers in detached mode     |
| `dcdown`      | Stop and remove containers            |
| `dls`         | List all Docker containers            |
| `dclogs`      | Follow Docker Compose logs            |
| `dcupdate`    | Pull images & recreate containers     |

## 📂 Repository Structure

```text
dotfiles/
├── bash/
│   └── bash_aliases
├── scripts/
│   └── install.sh
└── README.md
```

---

Made with ❤️ by [Bibek Aryal](https://bibeka.com.np/).
