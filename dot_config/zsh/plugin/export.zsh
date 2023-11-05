#!/bin/sh

HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export BROWSER="brave"
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/share/neovim/bin":$PATH

eval "$(starship init zsh)"
eval `keychain --eval --agents ssh id_ed25519`
