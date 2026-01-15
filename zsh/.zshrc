# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$HOME/.local/bin"

ZSH_THEME=""

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    )

source $ZSH/oh-my-zsh.sh

alias files="ls -lah"

# System
# alias update='sudo apt update && sudo apt upgrade'
alias install='sudo dnf install'
# alias remove='sudo dnf remove'

# folders
alias home='cd ~'
alias downloads='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dotfiles="cd ~/dotfiles"

# Configs shortcuts
alias reload='source ~/.zshrc'
alias zshconf='zed ~/dotfiles/zsh/.zshrc'
# alias terminalconf="zed ~/dotfiles/alacritty/.config/alacritty/alacritty.toml"
alias starshipconf="zed ~/dotfiles/starship/.config/starship.toml"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
