# General
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LANG en_US.UTF-8

## System
ulimit -n 2048 # Increase resource usage limits to 2048. Default is 256

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

## fzf
set -l FD_OPTIONS "--hidden --follow --exclude .git --exclude node_modules"
set -Ux FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard &> /dev/null | fd --type f --type l $FD_OPTIONS"
# Generated via fzf-lua
set -l kanagawa_colors "--color=spinner:#957FB8,marker:#957FB8,pointer:#E46876,hl+:#957FB8,gutter:#1F1F28,bg+:#363646,bg:#1F1F28,fg+:#DCD7BA,hl:#727169,prompt:#957FB8,header:#727169,info:#FFA066"
set -Ux FZF_DEFAULT_OPTS "--height 40% --layout=reverse --info=inline $kanagawa_colors"
set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

## pyenv
set -Ux PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M" # Use aria2c when downloading
## virtualfish
set -Ux VIRTUALFISH_HOME $HOME/.local/share/virtualenvs
## asdf-direnv
set -Ux DIRENV_LOG_FORMAT ""
## bat
set -Ux BAT_THEME Dracula
set -Ux fish_user_paths
## gopath
set -Ux GOPATH ~/go
## Bun
set -Ux BUN_INSTALL "$HOME/.bun"
## whalebrew
set -Ux WHALEBREW_INSTALL_PATH ~/.local/bin

# Path
## homebrew
fish_add_path /opt/homebrew/bin
## sysad binaries
fish_add_path /opt/homebrew/sbin
## mysql client
fish_add_path /opt/homebrew/opt/mysql-client/bin
## psql client
fish_add_path /opt/homebrew/opt/libpq/bin
## python
fish_add_path /opt/homebrew/opt/python@3.{11,10,9,8}/bin
fish_add_path /opt/homebrew/opt/python/libexec/bin

## golang
fish_add_path $GOPATH $GOPATH/bin
## cargo
fish_add_path ~/.cargo/bin
## asdf + asdf-direnv
fish_add_path ~/.asdf/bin
## bun
fish_add_path ~/.bun/bin
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
alias -s rscp "rsync -avhW --progress" # for copying local files
alias -s rsmv "rsync -avhW --no-compress --progress --remove-source-files"
alias -s tree "exa --tree"
alias -s kd "killall Dock"
alias -s vifish "$EDITOR ~/.config/fish/config.fish"
alias -s pmr "pm runserver"
alias -s lzdocker "TERM=$PARENT_TERM lazydocker"
alias -s vi nvim
alias -s minvim "nvim -u NORC"
alias -s ssht "TERM=screen ssh"
alias -s zki 'ZK_NOTEBOOK_DIR=~/Sync/notes/ zk new --no-input "$ZK_NOTEBOOK_DIR/brain"'
alias -s loadsshkeys "ls -d ~/.ssh/* -I '*.pub|config|environment|pems|known_hosts' | xargs ssh-add --apple-load-keychain &> /dev/null"

alias -s ls "exa --color=always --icons --group-directories-first --classify"
alias -s la "exa --color=always --icons --group-directories-first --classify --all"
alias -s ll "exa --color=always --icons --group-directories-first --classify --all --long"

alias -s ge "graph-easy"

# abbreviations
abbr cp "cp -iv"
abbr mv "mv -iv"

abbr t tmux

abbr l ll
