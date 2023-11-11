#!/bin/sh

HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export BROWSER="brave"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/share/neovim/bin":$PATH
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PYTHONUSERBASE="$XDG_DATA_HOME"/python
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export HISTFILE="$XDG_STATE_HOME"/bash/history

eval "$(starship init zsh)"
