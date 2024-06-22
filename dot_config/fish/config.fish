# General
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx LANG en_US.UTF-8

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# X = suppress alternate screen
# -#.25 = scroll horizontally by quarter of screen width (default is half)
set -gx LESS "-iFRMX-#.25"

## System
ulimit -n 16384 # Increase resource usage limits to 16384 Default is 256

## Since we are either using tmux or just default shell we want to check if
## PARENT_TERM is set by our tmux config so we can use it for other programs
set -q PARENT_TERM || set PARENT_TERM $TERM

# Load universal config when it's changed
set -l fish_config_mtime
# Test if we are on macOS or Linux
if test -d /Applications
    set fish_config_mtime (/usr/bin/stat -f %m $__fish_config_dir/config.fish)
else
    set fish_config_mtime (/usr/bin/stat -c %Y $__fish_config_dir/config.fish)
end

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
set -Ux XDG_CONFIG_HOME $HOME/.config
## fzf
set -Ux FZF_DEFAULT_OPTS_FILE $XDG_CONFIG_HOME/fzf/config
## virtualfish
set -Ux VIRTUALFISH_HOME $HOME/.local/share/virtualenvs
## Bun
set -Ux BUN_INSTALL $HOME/.bun
## whalebrew
set -Ux WHALEBREW_INSTALL_PATH $HOME/.local/bin
## zk
set -Ux ZK_SHELL /bin/zsh
## go
set -Ux GOPATH $HOME/go
## homebrew cask
set -Ux HOMEBREW_CASK_OPTS --no-quarantine

# Path
set -Ux fish_user_paths
## macos defaults
fish_add_path /usr/local/bin
## homebrew bin
fish_add_path $HOMEBREW_PREFIX/sbin $HOMEBREW_PREFIX/bin
## mysql client
fish_add_path $HOMEBREW_PREFIX/opt/mysql-client/bin
## psql client
fish_add_path $HOMEBREW_PREFIX/opt/libpq/bin
## python
fish_add_path $HOMEBREW_PREFIX/opt/python/libexec/bin
## golang
fish_add_path $GOPATH $GOPATH/bin
## cargo
fish_add_path $HOME/.cargo/bin
## mise shims
fish_add_path $HOME/.local/share/mise/shims
## local binaries
fish_add_path $HOME/.local/bin

# aliases
alias -s brewup "brew update; brew upgrade; brew cleanup; brew doctor"
alias -s cat bat
alias -s dc "docker compose"
alias -s getip "curl ipinfo.io/ip"
alias -s g git
alias -s localip "ipconfig getifaddr en0"
alias -s rscp "rsync -avhE --progress" # for copying local files
alias -s rsmv "rsync -avhE --no-compress --progress --remove-source-files"
alias -s tree "eza --tree"
alias -s kd "rm /var/folders/*/*/*/com.apple.dock.iconcache; killall Dock"
alias -s vifish "$EDITOR ~/.config/fish/config.fish"
alias -s pmr "pm runserver"
alias -s minvim "NVIM_APPNAME=minvim nvim"
alias -s ssht "TERM=screen ssh"
alias -s zki 'cd ~/Sync/notes/ && zk i'
alias -s loadsshkeys "ls -d ~/.ssh/* -I '*.pub|config|environment|pems|known_hosts' | xargs ssh-add --apple-load-keychain &> /dev/null"
alias -s untar "tar -xvf"
alias -s ls "eza --color=always --icons --group-directories-first --classify"
alias -s la "eza --color=always --icons --group-directories-first --classify --all"
alias -s ll "eza --color=always --icons --group-directories-first --classify --all --long"
alias -s ge graph-easy
alias -s icat "kitty +kitten icat"
alias -s ccurl "curl -OJL" # download file with original name
alias -s nvim-upgrade-nightly "nvim -v && echo 'Updating neovim@nightly...' && mise uninstall neovim@nightly -q && mise install neovim@nightly -q && nvim -v"
alias -s cls "clear; printf '\e[3J'"
