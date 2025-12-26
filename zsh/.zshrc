# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    )

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

alias files="ls -lah"

# System
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'

# folders
alias home='cd ~'
alias downloads='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dotfiles="cd ~/dotfiles"

# open file
alias hxf='fzf -m --preview="cat {}" --bind "enter:become(hx {+})"'
alias codef='fzf -m --preview="cat {}" --bind "enter:become(hx {+})"'

# switch into progr folders
progr() {
    case "$1" in
        -vkn)
            cd ~/progr/github_vkn
            ;;
        -k4in)
            cd ~/progr/github_k4in
            ;;
        -rinastt)
            cd ~/progr/github_rinastt
            ;;
        "")
            cd ~/progr
            ;;
        *)
            echo "Unbekannte Option: $1"
            return 1
            ;;
    esac
}

# Configs shortcuts
alias reload='source ~/.zshrc'
alias zshconf='code ~/.zshrc'
alias terminalconf="code ~/.config/alacritty/alacritty.toml"
alias starshipconf="code ~/.config/starship.toml"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
