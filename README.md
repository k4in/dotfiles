# Dotfiles

Linux (Fedora) dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

> **Package rule:** always prefer `dnf` (or COPR + `dnf`) when possible. Other install methods below are alternatives only.

## Contents

- [Required dependencies](#required-dependencies)
  - [zsh, stow & git](#zsh-stow--git)
  - [ghostty](#ghostty)
  - [starship](#starship)
  - [zoxide](#zoxide)
  - [zsh plugins](#zsh-plugins)
  - [fzf](#fzf)
  - [nvm, node, npm & pnpm](#nvm-node-npm--pnpm)
- [Optional dependencies](#optional-dependencies)
  - [lazygit](#lazygit)
  - [zed](#zed)
  - [pi coding agent](#pi-coding-agent)
  - [herdr](#herdr)
- [Installation](#installation)
  - [SSH key & config](#ssh-key--config)
  - [Stow a config](#stow-a-config)

---

## Required dependencies

### zsh, stow & git

```bash
sudo dnf install zsh stow git
chsh -s $(which zsh) # set zsh as default shell
```

Reload the shell after changing it.

### ghostty

Terminal (only if the default is not enough): <https://ghostty.org/>

### starship

Prompt: <https://starship.rs/>

```bash
sudo dnf copr enable atim/starship
sudo dnf install starship
```

### zoxide

A smarter `cd` command: <https://github.com/ajeetdsouza/zoxide> · <https://zoxide.org/>

```bash
sudo dnf install zoxide
```

Or install the binary manually:

```bash
# download latest binary and extract
mv zoxide ~/.local/bin/zoxide
chmod +x ~/.local/bin/zoxide
```

### zsh plugins

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

No packages available — clone into `~/.zsh`:

```bash
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
```

### fzf

Fuzzy finder: <https://github.com/junegunn/fzf> · <https://junegunn.github.io/fzf/>

```bash
sudo dnf install fzf
```

### nvm, node, npm & pnpm

Install Node via [nvm](https://nodejs.org/en) (on servers, install Node directly). Update npm after installing Node.

Install pnpm via [corepack](https://pnpm.io/):

```bash
# inside a project:
corepack use pnpm@latest-11
```

**Convention**

| Scope            | Tool          |
| ---------------- | ------------- |
| Global packages  | `npm` is fine |
| Project packages | always `pnpm` |

After a Node version change, reinstall globals and enable pnpm with:

```bash
npm install -g --ignore-scripts npm corepack @earendil-works/pi-coding-agent
corepack enable
```

---

## Optional dependencies

### lazygit

Simple terminal UI for git: <https://github.com/jesseduffield/lazygit>

```bash
sudo sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit
```

Or install the binary manually:

```bash
# download latest binary and extract
mv lazygit ~/.local/bin/lazygit
chmod +x ~/.local/bin/lazygit
```

### zed

Editor: <https://zed.dev>

Required extensions: HTML, TOML, Git Firefly, Colored Zed Icons Theme, Color Highlight

### pi coding agent

Docs: <https://pi.dev/docs/latest>

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

Self-written extensions live in [`pi-extensions/`](pi-extensions/) and can be installed with `pi install ~/dotfiles/pi-extensions`.

Install [find-skills](https://www.skills.sh/vercel-labs/skills/find-skills) globally; all other skills should be installed per project (`pi install -l …`).

#### ~~xAI extension~~ (deprecated)

<https://pi.dev/packages/pi-xai-oauth>

```bash
pi install npm:pi-xai-oauth
```

### herdr

Runtime for coding agents: <https://herdr.dev> · [install](https://herdr.dev/docs/install/)

No `dnf` package — install the binary:

```bash
curl -fsSL https://herdr.dev/install.sh | sh
```

Or download the latest binary from [GitHub releases](https://github.com/herdrdev/herdr/releases) and place it on your PATH:

```bash
# download latest binary for your platform
mv herdr-linux-x86_64 ~/.local/bin/herdr
chmod +x ~/.local/bin/herdr
```

---

## Installation

Prerequisites: `zsh`, `stow`, and `git` are installed (see [above](#zsh-stow--git)).

### SSH key & config

```bash
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t ed25519 -C "<usage>"
touch config
```

Example `~/.ssh/config`:

```ssh-config
Host github_<user>
    HostName github.com
    User git
    IdentityFile ~/.ssh/<keyfile>
    IdentitiesOnly yes # important with more than one SSH key
    # AddKeysToAgent yes # optional: add key to ssh-agent on first use
```

### Stow a config

1. Clone this repo to `~/dotfiles` if you have not already.
2. Remove any existing local configs you want to replace.
3. Stow the packages you need:

```bash
cd ~/dotfiles/configs
stow -t ~ zsh # example: restore zsh
```
