# Ensure fisherman and plugins are install
# if not functions -q fisher
#   echo "===> Installing fisher..."
#   set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
#   curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
#   sleep 1
#   # fish -c fisher
# end

# Notes:
# -x : --export
# -g : --global
# -U : --universal
# -q : --query
# https://nothingbutsnark.svbtle.com/trying-out-the-fish-shell
# Use -g for setting environment variables. When using the `-U`, even if we delete
# it in this config, it will still exists until such time that we unset it.

# General
set -gx EDITOR (type -p nvim)
set -gx LANG en_US.UTF-8
set -gx MYVIMRC $HOME/.vimrc

# Use neovim as the default man pager. Type :h Man for more info
set -gx MANPAGER "nvim +Man!"
set -gx MANWIDTH 999

set -gx XDG_CONFIG_HOME $HOME/.config

contains $HOME/.local/bin $fish_user_paths; or set -Ua fish_user_paths $HOME/.local/bin
contains /usr/local/sbin $fish_user_paths; or set -Ua fish_user_paths /usr/local/sbin
contains /usr/local/opt/mysql-client/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/opt/mysql-client/bin

# Autojump
set -x Z_CMD j

# FZF
set -l FD_OPTIONS "--hidden --follow --exclude .git --exclude node_modules"
set -gx FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard || fd --type f --type l $FD_OPTIONS"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview-window down:1"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

set -gx VIRTUALENVS_DIR $HOME/.local/share/virtualenvs

# pyenv
set -gx PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M" # Use aria2c when downloading

# neovim
set -gx PYTHON_3_HOST_PROG $VIRTUALENVS_DIR/nvim/bin/python3


# asdf
# Installation method via git since brew --prefix asdf is slow
# Manually added ~/.asdf/bin to the path so we don't have to use shims in favor of direnv
# Load the asdf wrapper function
source $HOME/.asdf/asdf.fish
set -gx ASDF_SKIP_RESHIM 1

# System
# Increase resource usage limits to 2048. Default is 256
ulimit -n 2048

# aliases
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"
alias cat="bat"
alias cp="cp -v"
alias dc="docker compose"
alias doom="~/.emacs.d/bin/doom"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dotlocal="/usr/bin/git --git-dir=$HOME/.dotlocal/ --work-tree=$HOME"
alias getip="curl ipinfo.io/ip"
alias g="git"
alias groot="cd ./(git rev-parse --show-cdup)"
alias localip="ipconfig getifaddr en0"
alias mv="mv -v"
alias ppath="echo $PATH | tr -s ':' '\n'"
alias fupath="echo $fish_user_paths | tr ' ' '\n'"
alias rscp="rsync -avhW --progress" # for copying local files
alias rsmv="rsync -avhW --no-compress --progress --remove-source-files"
alias t="tmux"
alias tree="exa --tree"
alias kd="killall Dock"
alias vi="nvim"
alias vifish="vi ~/.config/fish/config.fish"
alias pmr="pm runserver"

alias tmux_light="~/Sources/github.com/yujinyuz/dotfiles/./tokyonight_day.tmux"
alias tmux_dark="~/Sources/github.com/yujinyuz/dotfiles/./tokyonight_storm.tmux"
alias lzdocker="TERM=xterm-kitty lazydocker"
alias minvim="nvim -u NORC"
alias ssht="TERM=screen ssh"
