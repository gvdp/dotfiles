# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Installation

```bash
./install.sh              # Full install (brew, symlinks, shell, macos prefs)
./install.sh link         # Only run dotbot to re-create symlinks
./install.sh homebrew     # Only install/update Homebrew packages
```

After pulling changes, the `githooks/post-merge` hook runs `./install.sh link` automatically.

## Architecture

This is a dotfiles repository managed with [Dotbot](https://github.com/anishathalye/dotbot). Dotbot reads `install.conf.yaml` to create symlinks from the repo into the home directory.

### Symlink convention

Files and directories ending in `.symlink` are the primary targets for home-directory linking (e.g. `zsh/zshrc.symlink` → `~/.zshrc`). The `install.conf.yaml` also maps non-symlink paths — notably `vim/lazyvim` → `~/.config/nvim`.

### Local overrides

Machine-specific settings go in untracked local files sourced at the end of the main config:
- `~/.zshrc.local` — extra shell config, machine-specific aliases
- `~/.zshenv.local` — extra environment variables
- `~/.gitconfig-local` — local git identity overrides

### Zsh plugin management

Two plugin systems are in use simultaneously:
- **Oh-My-Zsh** (`~/.oh-my-zsh`) — framework providing completions and themes; plugins listed in `ZSH_PLUGINS` inside `zsh/zshrc.symlink`
- **Antidote** — manages additional plugins declared in `~/.zsh_plugins.txt`
- Custom zsh scripts live in `zsh/oh-my-zsh/custom/` and are auto-sourced by Oh-My-Zsh; each file groups aliases/functions by tool (git, docker, ember, laravel, netlify)

### Git identity switching

`git/gitconfig` uses `includeIf "hasconfig:remote.*.url:..."` to automatically apply `git/work` or `git/personal` based on the remote URL of each repository — no manual switching needed.

### Submodules

Dotbot itself and several zsh plugins are tracked as git submodules. After cloning, run:

```bash
git submodule update --init --recursive
```
