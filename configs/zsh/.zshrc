export PATH="$PATH:$HOME/.local/bin"

alias ls="ls -lah"
alias cd="z" #zoxide

# System
alias install='sudo dnf install'
alias remove='sudo dnf remove'

# Configs shortcuts
alias reload='source ~/.zshrc'
alias dotfiles="zed ~/dotfiles"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
