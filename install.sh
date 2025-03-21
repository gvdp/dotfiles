#!/usr/bin/env bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

get_linkables() {
    find -H "$DOTFILES" -maxdepth 3 -name '*.symlink'
}

backup() {
    BACKUP_DIR=$HOME/dotfiles-backup

    echo "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    for file in $(get_linkables); do
        filename=".$(basename "$file" '.symlink')"
        target="$HOME/$filename"
        if [ -f "$target" ]; then
            echo "backing up $filename"
            cp "$target" "$BACKUP_DIR"
        else
            warning "$filename does not exist at this location or is a symlink"
        fi
    done

    for filename in "$HOME/.config/nvim" "$HOME/.vim" "$HOME/.vimrc"; do
        if [ ! -L "$filename" ]; then
            echo "backing up $filename"
            cp -rf "$filename" "$BACKUP_DIR"
        else
            warning "$filename does not exist at this location or is a symlink"
        fi
    done
}


setup_symlinks() {
    title "Creating symlinks"
    ./run-dotbot
    # mackup restore
}

setup_git() {
    title "Setting up Git"
    git config core.hooksPath githooks
#
    defaultName=$(git config user.name)
    defaultEmail=$(git config user.email)
    defaultGithub=$(git config github.user)

    read -rp "Name [$defaultName] " name
    read -rp "Email [$defaultEmail] " email
    read -rp "Github username [$defaultGithub] " github

    git config -f ~/.gitconfig-local user.name "${name:-$defaultName}"
    git config -f ~/.gitconfig-local user.email "${email:-$defaultEmail}"
    git config -f ~/.gitconfig-local github.user "${github:-$defaultGithub}"

    ssh-keygen -t ed25519 -C "vdputteglenn@gmail.com"
    eval "$(ssh-agent -s)"

#    if [[ "$(uname)" == "Darwin" ]]; then
#        git config --global credential.helper "osxkeychain"
#    else
#        read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
#        if [[ $save =~ ^([Yy])$ ]]; then
#            git config --global credential.helper "store"
#        else
#            git config --global credential.helper "cache --timeout 3600"
#        fi
#    fi
}

setup_homebrew() {
    title "Setting up Homebrew"

    if test ! "$(command -v brew)"; then
        info "Homebrew not installed. Installing."
        # Run as a login shell (non-interactive) so that the script doesn't pause for user input
	# todo: needs sudo so doesnt work out of the box
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
    fi

    # install brew dependencies from Brewfile
    brew bundle

    # install fzf
    echo -e
    info "Installing fzf"
    "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

     # install volta ...
	curl https://get.volta.sh | bash

    # install vim plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}



function setup_shell() {
    title "Configuring shell"

    zsh_path="$(which zsh)"
    if ! grep "$zsh_path" /etc/shells; then
        info "adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        info "default shell changed to $zsh_path"
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

}

#function setup_terminfo() {
#    title "Configuring terminfo"
#
#    info "adding tmux.terminfo"
#    tic -x "$DOTFILES/resources/tmux.terminfo"
#
#    info "adding xterm-256color-italic.terminfo"
#    tic -x "$DOTFILES/resources/xterm-256color-italic.terminfo"
#}

setup_macos() {
    title "Configuring macOS"
    if [[ "$(uname)" == "Darwin" ]]; then

#        echo "Finder: show all filename extensions"
#        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        echo "show hidden files by default"
        defaults write com.apple.Finder AppleShowAllFiles -bool true

        echo "only use UTF-8 in Terminal.app"
        defaults write com.apple.terminal StringEncodings -array 4

#        echo "expand save dialog by default"
#        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

#        echo "show the ~/Library folder in Finder"
#        chflags nohidden ~/Library

#        echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
#        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#        echo "Enable subpixel font rendering on non-Apple LCDs"
#        defaults write NSGlobalDomain AppleFontSmoothing -int 2

#        echo "Use current directory as default search scope in Finder"
#        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#        echo "Show Path bar in Finder"
#        defaults write com.apple.finder ShowPathbar -bool true

#        echo "Show Status bar in Finder"
#        defaults write com.apple.finder ShowStatusBar -bool true

#        echo "Disable press-and-hold for keys in favor of key repeat"
#        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#        echo "Set a blazingly fast keyboard repeat rate"
#        defaults write NSGlobalDomain KeyRepeat -int 1

#        echo "Set a shorter Delay until key repeat"
#        defaults write NSGlobalDomain InitialKeyRepeat -int 15

#        echo "Enable tap to click (Trackpad)"
#        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

#        echo "Enable Safari’s debug menu"
#        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

        echo "Kill affected applications"

        for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
    else
        warning "macOS not detected. Skipping."
    fi
}

case "$1" in
    backup)
        backup
        ;;
    link)
        setup_symlinks
        ;;
    git)
        setup_git
        ;;
    homebrew)
        setup_homebrew
        ;;
    shell)
        setup_shell
        ;;
    terminfo)
        setup_terminfo
        ;;
    macos)
        setup_macos
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {backup|link|git|homebrew|shell|terminfo|macos|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
