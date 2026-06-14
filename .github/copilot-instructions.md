# GitHub Copilot Instructions

This repository manages the user's dotfiles using [Dotbot](https://github.com/anishathalye/dotbot) and a custom installation script.

## Build, Test, and Lint Commands

There is no traditional build or test suite. The "build" process is the installation and linking of dotfiles.

- **Full Installation**: `./install.sh` (defaults to backup, link, git, homebrew, shell, terminfo, macos)
- **Link Dotfiles Only**: `./install.sh link`
- **Install Homebrew Dependencies**: `./install.sh homebrew`
- **Configure Shell (Zsh)**: `./install.sh shell`
- **Configure macOS Defaults**: `./install.sh macos`
- **Backup Existing Configs**: `./install.sh backup`

Dependencies are managed via `Brewfile`. To update dependencies:
- `brew bundle dump --force` (updates `Brewfile` from current system state)
- `brew bundle install` (installs from `Brewfile`)

## High-Level Architecture

The repository uses a topic-based structure where configurations are grouped by application or purpose (e.g., `zsh/`, `vim/`, `git/`).

- **Entry Point**: `install.sh` acts as the master script, orchestrating various setup tasks.
- **Symlinking**: handled by `dotbot`, configured in `install.conf.yaml`.
- **Shell**: Zsh is the primary shell, using Oh My Zsh. Configuration is split into:
  - `zsh/zshrc.symlink`: Main configuration linked to `~/.zshrc`.
  - `zsh/zshenv.symlink`: Environment variables linked to `~/.zshenv`.
  - `zsh/zprofile.symlink`: Login shell config linked to `~/.zprofile`.
- **Editor**: Neovim configuration is based on [LazyVim](https://www.lazyvim.org/), located in `vim/lazyvim` and linked to `~/.config/nvim`.
- **Terminal**: Configurations for Kitty (`kitty/`) and WezTerm (`wezterm/`).
- **Backup**: `mackup` is configured to use the file system backend (`mackup/.mackup.cfg`) for syncing application settings.

## Key Conventions

- **Symlink Naming**: Files intended to be symlinked to the home directory often end in `.symlink` (e.g., `zsh/zshrc.symlink`).
- **Configuration**: Always check `install.conf.yaml` to verify or modify symlink targets. Do not assume a file is linked unless it is listed there.
- **Secrets**: Avoid committing secrets. Use separate files (e.g., `~/.gitconfig-local`, `.zshrc.local`) for sensitive information, as seen in `install.sh` handling of git config.
- **Idempotency**: Scripts should be idempotent. `install.sh` checks for existence before installing (e.g., checking `command -v brew`).
- **Path References**: Use `$DOTFILES` or relative paths when referring to files within the repository in scripts.
