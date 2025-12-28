# dotfiles

my dotfiles and settings.

## stow

make sure that stow is installed

## Rust

[install Rust](https://rust-lang.org/tools/install/) via rustup to be able to use cargo for dependencies

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Alacritty
Terminal of choice. [Website](https://alacritty.org/)

## oh-my-zsh
Plugin-Framework for zsh-shell. [Website](https://ohmyz.sh/#install)

## NodeJS + NVM

install NVM, then NodeJS (wip)

## Tools
### Helix
#### Installation
Install binaries directly according to instructions.
[Website](https://docs.helix-editor.com/install.html)
[Github](https://github.com/helix-editor/helix)
#### LSPs
##### marksman
install binaries directly from github. make sure $HOME/.local/bin is in $PATH
[Github](https://github.com/artempyanykh/marksman/blob/main/docs/install.md)

##### typescript-language-server
```bash
npm i -g typescript typescript-language-server
```

##### taplo
```bash
cargo install taplo-cli --locked --features lsp
```

### Zellij
Multiplexer for Terminal. [Website](https://zellij.dev/)
Can be installed via Cargo. [Docs](https://zellij.dev/documentation/installation.html)
