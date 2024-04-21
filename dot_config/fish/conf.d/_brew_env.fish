# Modified shellenv where we exclude fish_add_path and just manually add it in our config.fish instead
# this is to avoid reording of PATH in fish shell.
# It's not necessary to do this but sometimes when I invoke $SHELL within vim, it causes the $PATH
# to reorder.
if test (uname -m) = arm64
    eval (/opt/homebrew/bin/brew shellenv | grep -v fish_add_path)
else
    eval (/usr/local/bin/brew shellenv | grep -v fish_add_path)
end
