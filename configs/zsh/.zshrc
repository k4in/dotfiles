# add ~/.local/bin to $PATH
export PATH="$PATH:$HOME/.local/bin"

alias ls="ls -lah"

# dnf shortcuts
alias install='sudo dnf install'
alias remove='sudo dnf remove'

# reload shortcut
alias reload='source ~/.zshrc'

# open dotfiles shortcut
alias dotfiles="zed ~/dotfiles"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z" #zoxide

# fzf
source <(fzf --zsh)

# nvm + node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/fedora/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# zsh plugins (should always be last!)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
