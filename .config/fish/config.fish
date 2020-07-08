# Ensure fisherman and plugins are installed
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

set -gx EDITOR nvim
set -x Z_CMD "j"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -x PYENV_ROOT $HOME/.pyenv
set -gx PYTHON_3_HOST_PROG $PYENV_ROOT/versions/nvim/bin/python3

set -x FD_OPTIONS "--hidden --follow --exclude .git --exclude node_modules"
set -x FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git --exclude node_modules"
set -x FZF_CTRL_T_COMMAND "git ls-files --cached --others --exclude-standard | fd --type f --type l --hidden --follow --exclude .git --exclude node_modules"
set -x FZF_DEFAULT_COMMAND "git ls-files --cached --others --exclude-standard | fd --type f --type l --hidden --follow --exclude .git --exclude node_modules"
set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview-window down:1"

set -g nvm_alias_output $HOME/.node_aliases

# Prevent duplicates in `fish_user_paths`
if not set -q FIRST_RUN
  # If you want to override fish_user_paths, run:
  # update_fish_user_paths
  set -U FIRST_RUN (date)
  set -Ux fish_user_paths \
            $PYENV_ROOT/bin \
            $HOME/.node_aliases \
            $fish_user_paths
end

status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source
type -q install_python_provider; and install_python_provider # for neovim


# aliases
alias cat="bat"
alias cp="cp -v"
alias doom="~/.emacs.d/bin/doom"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dotlocal="/usr/bin/git --git-dir=$HOME/.dotlocal/ --work-tree=$HOME"
alias eb="~/.ebcli-virtual-env/bin/eb"
alias mv="mv -v"
alias pm="python manage.py"
alias ppath="echo $fish_user_paths | tr ' ' '\n' | nl"
alias rscp="rsync -avhW --no-compress --progress" # for copying local files
alias rsmv="rsync -avhW --no-compress --progress --remove-source-files"
alias t="tmux"
alias vi="nvim"

# abbreviations
if status --is-interactive
  abbr --add --global t tmux
  abbr --add --global ta tmux attach -t
  abbr --add --global tn tmux new-session -A -s
end
