# Dependencies

dotfiles/instructions are optimized for linux fedora

All packages should always be installed via dnf (or copr/dnf) if possible. Other suggested installation methods below are alternatives only!

## zsh (shell) + stow + git

```bash 
sudo dnf install zsh stow git # install zsh, stow, git
chsh -s $(which zsh) # set zsh as default shell
```

restart device after shell change!

### ghostty (as terminal, only if standard terminal is not sufficient)
<https://ghostty.org/>

### starship (prompt)
<https://starship.rs/>

```bash
dnf copr enable atim/starship
dnf install starship
```

### zoxide

A smarter cd command.

<https://github.com/ajeetdsouza/zoxide>
<https://zoxide.org/>

```bash
sudo dnf install zoxide
```

or

```bash
# download latest binary and extract
mv zoxide ~/.local/bin/zoxide
chmod +x ~/.local/bin/zoxide # give executable rights to binary
```

### zsh-autosuggestions and zsh-syntax-highlighting
<https://github.com/zsh-users/zsh-autosuggestions>
<https://github.com/zsh-users/zsh-syntax-highlighting>

There is no binary, we have to clone the repo.

```bash
mkdir ~/.zsh # only if directory doesn't exist
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
```

### fzf

<https://github.com/junegunn/fzf> <https://junegunn.github.io/fzf/>

```bash
sudo dnf install fzf
```

### lazygit

Simple terminal UI for git commands

<https://github.com/jesseduffield/lazygit>

```bash
sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit
```
or

```bash
# download latest binary and extract
mv lazygit ~/.local/bin/lazygit
chmod +x ~/.local/bin/lazygit # give executable rights to binary
```



## zed (editor)

<https://zed.dev>

required extensions: HTML, TOML, Git Firefly, Colored Zed Icons Theme, Color Highlight

## nvm + nodejs + npm
<https://nodejs.org/en>

# Installation

1. Make sure zsh, stow and git are installed.
2. Create ssh key and ssh config
    ```bash
    # mkdir ~/.ssh if directory doesn't exist
    cd ~/.ssh
    ssh-keygen -t ed25519 -C "<usage>"
    
    # create config
    touch config
    ```
    
    ```bash
    # ~/.ssh/config
    Host github_<user>
        HostName github.com # url or ip of the Host
        User git # ssh user
        IdentityFile ~/.ssh/<keyfile> #path to keyfile
        IdentitiesOnly yes # important setting, especially with more than one ssh-key.
        # AddKeysToAgent yes # optional, adds key to ssh-agent on first use.
        
    ```
3. clone dotfiles repo to ~/dotfiles
4. stow needed configs. delete existing local configs before restoring.
    ```bash
    cd ~/dotfiles/configs
    stow -t ~ zsh # to restore zsh
    ```
