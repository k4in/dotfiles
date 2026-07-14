# Required Dependencies

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

## nvm + nodejs + npm + pnpm

<https://nodejs.org/en>
install node via nvm, on servers install directly. make sure to update npm after node installation.

install pnpm via corepack.

<https://pnpm.io/>

```bash
# inside a project:
corepack use pnpm@latest-11
```

Basic convention: Global packages CAN be installed via npm. Project-Packages should always be installed with pnpm.

Useful global packages: npm, corepack, opencode-ai, @earendil-works/pi-coding-agent

# Optional Dependencies

## lazygit

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

## pi coding agent:

<https://pi.dev/docs/latest>

install globally via npm

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

#### xAI extension

<https://pi.dev/packages/pi-xai-oauth>

```bash
pi install npm:pi-xai-oauth
```

## opencode

<https://opencode.ai>

install globally via npm

```bash
npm i -g opencode-ai
```

# Installation

Make sure zsh, stow and git are installed.

## create ssh key and ssh config

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

## stow a config

- if not done yet, clone dotfiles repo to ~/dotfiles
- stow needed configs. delete existing local configs before restoring.
  ```bash
  cd ~/dotfiles/configs
  stow -t ~ zsh # to restore zsh
  ```
