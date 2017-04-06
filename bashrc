#!/usr/bin/env bash

source ~/dotfiles/bash/config

# aliases
source ~/dotfiles/shell/macros.sh
source ~/dotfiles/shell/aliases.sh

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
