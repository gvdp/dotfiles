# Dotfiles

This repository contains personal configuration files (dotfiles) for macOS, managed using [Dotbot](https://github.com/anishathalye/dotbot).

## Project Overview

- **Management:** Dotbot for symlinking configurations.
- **Shell:** Zsh with [Oh My Zsh](https://ohmyz.sh/), [Antidote](https://getantidote.github.io/) for plugins, and [Starship](https://starship.rs/) for the prompt.
- **Editor:** Neovim configured with [LazyVim](https://www.lazyvim.org/).
- **Package Manager:** [Homebrew](https://brew.sh/) (managed via `Brewfile`).
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/) and [Wezterm](https://wezfurlong.org/wezterm/).
- **Other Tools:** Tmux, Volta (Node.js), Pyenv (Python), Rbenv (Ruby), Mackup.

## Key Files & Directories

- `install.conf.yaml`: The Dotbot configuration file mapping source files to their symlink locations in `$HOME`.
- `install.sh`: A multi-purpose setup script for backup, linking, and configuring various system components.
- `run-dotbot`: A wrapper script to execute Dotbot with the repository's configuration.
- `Brewfile`: Lists all Homebrew formulae, casks, and App Store applications to be installed.
- `zsh/`: Contains Zsh configuration files (`.zshrc`, `.zshenv`, etc.) and custom functions.
- `vim/lazyvim/`: Neovim configuration following the LazyVim structure.
- `git/`: Global Git configuration and ignore files.

## Installation & Usage

The `install.sh` script is the primary entry point for setting up the environment. It supports several subcommands:

```bash
./install.sh {backup|link|git|homebrew|shell|macos}
```

### Key Commands

- **Link configurations:** Runs Dotbot to create symlinks based on `install.conf.yaml`.
  ```bash
  ./install.sh link
  ```
- **Install dependencies:** Installs Homebrew (if missing) and all packages listed in the `Brewfile`.
  ```bash
  ./install.sh homebrew
  ```
- **Setup Shell:** Configures Zsh as the default shell and installs Oh My Zsh.
  ```bash
  ./install.sh shell
  ```
- **Configure Git:** Interactively sets up global Git identity and SSH keys.
  ```bash
  ./install.sh git
  ```
- **macOS Defaults:** Applies various macOS system defaults (e.g., showing hidden files).
  ```bash
  ./install.sh macos
  ```
- **Backup:** Backs up existing configuration files to `~/dotfiles-backup`.
  ```bash
  ./install.sh backup
  ```

## Development Conventions

- **Modular Configuration:** Configurations for different tools are organized into their own directories (e.g., `zsh/`, `kitty/`, `tmux/`).
- **Symlinking:** Most files are intended to be symlinked to the home directory or `~/.config`.
- **Local Overrides:** The Zsh configuration supports local overrides via `~/.zshrc.local`.
- **Plugin Management:**
  - Zsh plugins are managed via Antidote in `zsh/.zsh_plugins.txt`.
  - Neovim plugins are managed via LazyVim in `vim/lazyvim/`.
