# General
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LANG en_US.UTF-8

if test (uname -m) = arm64
    set -gx BREW_BASE /opt/homebrew
else
    set -gx BREW_BASE /usr/local
end

## System
ulimit -n 16384 # Increase resource usage limits to 16384 Default is 256

## Since we are either using tmux or just default shell we want to check if
## PARENT_TERM is set by our tmux config so we can use it for other programs
set -q PARENT_TERM || set PARENT_TERM $TERM


# Load universal config when it's changed
set -l fish_config_mtime
set fish_config_mtime (/usr/bin/stat -Lf %m $__fish_config_dir/config.fish)

set -l local_config $__fish_config_dir/config-local.fish
if test -f $local_config
    source $__fish_config_dir/config-local.fish
end

if test "$fish_config_changed" = "$fish_config_mtime"
    exit
else
    set -U fish_config_changed $fish_config_mtime
end

# Exports
## Use neovim as the default man pager. Type :h Man for more info
set -Ux MANPAGER "nvim +Man!"
set -Ux MANWIDTH 999

set -Ux XDG_CONFIG_HOME "$HOME/.config"

## fzf
set -l FD_OPTIONS "--hidden --follow --strip-cwd-prefix --exclude .git --exclude node_modules"
set -Ux FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard &> /dev/null | fd --type f --type l $FD_OPTIONS"

# Generated via fzf-lua
set -Ux FZF_DEFAULT_OPTS "--no-separator --height 40% --layout=reverse --info=inline --color=gutter:-1,bg+:-1" # The only important thing here is the gutter color to set it to transparent
set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

## n
### Generally, I'd prefer to just use  asdf for almost everything but
### it turns out that asdf-node plugin is using node-build under the hood
### which requires python and it doesn't work most of the time.
set -Ux N_PREFIX $HOME/.n
## virtualfish
set -Ux VIRTUALFISH_HOME $HOME/.local/share/virtualenvs
## asdf-direnv
set -Ux DIRENV_LOG_FORMAT ""
## bat
set -Ux BAT_THEME Dracula
## gopath
set -Ux GOPATH ~/go
## Bun
set -Ux BUN_INSTALL "$HOME/.bun"
## whalebrew
set -Ux WHALEBREW_INSTALL_PATH ~/.local/bin
## zk
set -Ux ZK_SHELL /bin/zsh

# Path
set -Ux fish_user_paths

## homebrew
fish_add_path $BREW_BASE/bin
## sysad binaries
fish_add_path $BREW_BASE/sbin
## mysql client
fish_add_path $BREW_BASE/opt/mysql-client/bin
## psql client
fish_add_path $BREW_BASE/opt/libpq/bin
## python
fish_add_path $BREW_BASE/opt/python@3.{12,11,10,9,8}/bin
fish_add_path $BREW_BASE/opt/python/libexec/bin

## golang
fish_add_path $GOPATH $GOPATH/bin
## cargo
fish_add_path ~/.cargo/bin
## asdf + asdf-direnv
fish_add_path ~/.asdf/bin
## local binaries
fish_add_path ~/.local/bin

# aliases
alias -s brewup "brew update; brew upgrade; brew cleanup; brew doctor"
alias -s cat bat
alias -s dc "docker compose"
alias -s getip "curl ipinfo.io/ip"
alias -s g git
alias -s groot "cd ./(git rev-parse --show-cdup)"
alias -s localip "ipconfig getifaddr en0"
alias -s rscp "rsync -avhE --progress" # for copying local files
alias -s rsmv "rsync -avhE --no-compress --progress --remove-source-files"
alias -s tree "exa --tree"
alias -s kd "killall Dock"
alias -s vifish "$EDITOR ~/.config/fish/config.fish"
alias -s pmr "pm runserver"
alias -s lzdocker "TERM=$PARENT_TERM lazydocker"
alias -s minvim "nvim -u ~/.minivim/init.lua"
alias -s ssht "TERM=screen ssh"
alias -s zki 'ZK_NOTEBOOK_DIR=~/Sync/notes/ zk new --no-input "$ZK_NOTEBOOK_DIR/brain"'
alias -s loadsshkeys "ls -d ~/.ssh/* -I '*.pub|config|environment|pems|known_hosts' | xargs ssh-add --apple-load-keychain &> /dev/null"
alias -s untar "tar -xvf"

alias -s ls "eza --color=always --icons --group-directories-first --classify"
alias -s la "eza --color=always --icons --group-directories-first --classify --all"
alias -s ll "eza --color=always --icons --group-directories-first --classify --all --long"

alias -s ge graph-easy
alias -s icat "kitty +kitten icat"
alias -s ccurl "curl -OJL" # download file with original name
