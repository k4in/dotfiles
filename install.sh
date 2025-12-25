#!/bin/bash

# 1. Define a helper function for logging
log() {
    echo -e "\033[1;32m[SETUP]\033[0m $1"
}

log "Starting setup..."

# 2. Install Package Manager / Base Tools
# (Example for Ubuntu/Debian - change 'apt' to 'brew' for Mac)
log "Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl build-essential cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# 3. Install Rust (The official way)
if ! command -v cargo &> /dev/null; then
    log "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    log "Rust is already installed."
fi

# 4. Install Alacritty (via Cargo since you have Rust)
if ! command -v alacritty &> /dev/null; then
    log "Installing Alacritty..."
    cargo install alacritty
else
    log "Alacritty is already installed."
fi

# 5. Install Zellij
if ! command -v zellij &> /dev/null; then
    log "Installing Zellij..."
    cargo install zellij
else
    log "Zellij is already installed."
fi

# 6. Install Starship
if ! command -v starship &> /dev/null; then
    log "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# 7. Install Oh My Zsh
# We check if the folder exists to avoid installing it twice
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Note: The --unattended flag prevents it from switching to zsh immediately and stopping the script
else
    log "Oh My Zsh is already installed."
fi

# 8. Install Zsh Plugins (Optional but common)
# Example: zsh-autosuggestions
AUTOSUGGEST_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
    log "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $AUTOSUGGEST_DIR
fi

# 9. Run Stow to link your config files
log "Stowing dotfiles..."
# Ensure stow is installed
if ! command -v stow &> /dev/null; then
    sudo apt install -y stow
fi

cd ~/dotfiles
stow alacritty
stow zsh
stow zellij
stow starship

log "Setup complete! Please restart your terminal."