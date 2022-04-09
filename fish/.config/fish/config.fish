# Notes:
# -x : --export
# -g : --global
# -U : --universal
# -q : --query
# https://nothingbutsnark.svbtle.com/trying-out-the-fish-shell
# Use -g for setting environment variables. When using the `-U`, even if we delete
# it in this config, it will still exists until such time that we unset it.

# General
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LANG en_US.UTF-8

# Load universal config when it's changed
set -l fish_config_mtime
set fish_config_mtime (/usr/bin/stat -Lf %m $__fish_config_dir/config.fish)

if test "$fish_config_changed" = "$fish_config_mtime"
    exit
else
    set -U fish_config_changed $fish_config_mtime
end

set -Ux fish_user_paths

# Path
fish_add_path ~/.local/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/mysql-client/bin
fish_add_path ~/.asdf/bin

# Exports
## Use neovim as the default man pager. Type :h Man for more info
set -Ux MANPAGER "nvim +Man!"
set -Ux MANWIDTH 999

## Autojump
set -Ux Z_CMD j

## FZF
set -l FD_OPTIONS "--hidden --follow --exclude .git --exclude node_modules"
set -Ux FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard &> /dev/null | fd --type f --type l $FD_OPTIONS"
set -Ux FZF_DEFAULT_OPTS "--height 40% --layout=reverse --info=inline --color='bg+:$BG_TMUX'"
set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

## pyenv
set -Ux PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M" # Use aria2c when downloading

## neovim
set -Ux PYTHON_3_HOST_PROG $VIRTUALENVS_DIR/nvim/bin/python3

## virtualfish
set -Ux VIRTUALFISH_HOME $HOME/.local/share/virtualenvs

## asdf-direnv
set -Ux DIRENV_LOG_FORMAT ""

## bat
set -Ux BAT_THEME Dracula

## System
# Increase resource usage limits to 2048. Default is 256
ulimit -n 2048

# aliases
alias -s brewup "brew update; brew upgrade; brew cleanup; brew doctor"
alias -s cat "bat"
alias -s direnv "$ASDF_DIRENV_BIN"
alias -s dc "docker compose"
alias -s getip "curl ipinfo.io/ip"
alias -s g "git"
alias -s groot "cd ./(git rev-parse --show-cdup)"
alias -s localip "ipconfig getifaddr en0"
alias -s ppath "echo $PATH | tr -s ':' '\n'"
alias -s fupath "echo $fish_user_paths | tr ' ' '\n'"
alias -s rscp "rsync -avhW --progress" # for copying local files
alias -s rsmv "rsync -avhW --no-compress --progress --remove-source-files"
alias -s tree "exa --tree"
alias -s kd "killall Dock"
alias -s vifish "$EDITOR ~/.config/fish/config.fish"
alias -s pmr "pm runserver"
alias -s lzdocker "TERM=xterm-kitty lazydocker"
alias -s minvim "nvim -u NORC"
alias -s ssht "TERM=screen ssh"
alias -s zki 'ZK_NOTEBOOK_DIR=~/Sync/notes/ zk new --no-input "$ZK_NOTEBOOK_DIR/brain"'

# abbreviations
abbr cp "cp -iv"
abbr mv "mv -iv"

abbr t "tmux"
abbr vi "nvim"
