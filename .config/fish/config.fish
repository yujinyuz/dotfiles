# Manually unset then set the PATH because it's duplicating in tmux.
# Only pyenv, rbenv, goenv are known to have duplicates because it doesn't
# check if the environment variable already exists
# set -gx PATH ""
# List can be found under /etc/paths on MacOS
# set -gx PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin $PATH

# Ensure fisherman and plugins are installe
if not functions -q fisher
  echo "===> Installing fisher..."
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  sleep 1
  fish -c fisher
end

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
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

contains $fish_user_paths $HOME/.local/bin; or set -Ua fish_user_paths $HOME/.local/bin

# Autojump
set -gx Z_CMD "j"

# pyenv
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M" # Use aria2c when downloading
contains $fish_user_paths $PYENV_ROOT/bin; or set -Ua fish_user_paths $PYENV_ROOT/bin
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source
type -q install_python_provider; and install_python_provider

# goenv
set -gx GOENV_GOPATH_PREFIX $HOME/.go
status --is-interactive; and goenv init - | source

# rbenv
status --is-interactive; and rbenv init - | source

# neovim
set -gx PYTHON_3_HOST_PROG $PYENV_ROOT/versions/nvim/bin/python3

# FZF
set -l FD_OPTIONS "--hidden --follow --exclude .git --exclude node_modules"
set -g -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview-window down:1"
set -g -x FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
set -g -x FZF_CTRL_T_COMMAND "fd $FD_OPTIONS"
set -g -x FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

# Set nvm aliases and add to path
set -gx nvm_alias_output $HOME/.node_aliases
contains $fish_user_paths $nvm_alias_output; or set -Ua fish_user_paths $nvm_alias_output

# aliases
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"
alias cat="bat"
alias cp="cp -v"
alias doom="~/.emacs.d/bin/doom"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dotlocal="/usr/bin/git --git-dir=$HOME/.dotlocal/ --work-tree=$HOME"
alias eb="~/.ebcli-virtual-env/bin/eb"
alias getip="curl ipinfo.io/ip"
alias localip="ifconfig|grep 'inet 192'|cut -d ' ' -f2"
alias mv="mv -v"
alias pm="python manage.py"
alias ppath="echo $PATH | tr -s ':' '\n'"
alias rscp="rsync -avhW --no-compress --progress" # for copying local files
alias rsmv="rsync -avhW --no-compress --progress --remove-source-files"
alias t="tmux"
# alias tn="tmux new-session -As 0"
alias tree="exa --tree --level=3"
alias vi="nvim"
alias vifish="vi ~/.config/fish/config.fish"

# abbreviations
if status --is-interactive
  abbr --add --global ta tmux attach -t
end
