# ~/.bashrc

# ===== Initialization ===== {{{
if [[ $DISPLAY ]]; then
    # If not running interactively, do not do anything
    [[ $- != *i* ]] && return
    [ -z "$TMUX" ] && exec tmux
fi
# ===== Initialization ===== }}}
# ===== Source files ===== {{{
# Source alias and functions
. ~/.bash_alias
. ~/.bash_functions

# Source ls colors
# . /usr/share/LS_COLORS/dircolors.sh
. ~/.local/share/lscolors.sh

# Source Git prompt
. /usr/share/git/completion/git-prompt.sh
# ===== Source files ===== }}}
# ===== Environment ===== {{{
# Set prompt
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# Set journalctl to wrap lines instead of truncating
export SYSTEMD_LESS=FRXMK

# Use LS_COLORS inside vidir session
# export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'
export VIDIR_EDITOR_ARGS="-c :set ft=vidir-ls"

# Set PAGER explicitly
export PAGER="less -R"

export EDITOR=vim
export XDG_CONFIG_HOME=~/.config
export GOPATH=$HOME/.go
export PATH="${HOME}/.bin:${GOPATH}/bin:${HOME}/.local/lib:${PATH}"
export BROWSER="qutebrowser"

# Diff tool for pacdiff
export DIFFPROG="vimdiff"
# ===== Environment ===== }}}
# ===== Autocomplete commands ===== {{{
# Enable bash Tab extended completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Complete command names
complete -c man which watch

# Complete command names as well as file names
complete -cf sudo

# pass completion
. /usr/share/pass/completion.bash
# ===== Autocomplete commands ===== }}}
# ===== NNN ===== {{{
# Set bookmarks for nnn
export NNN_BMS='D:~/Downloads/;'\
'P:~/Projects;'\
'p:~/Projects/photos;'\
'd:~/Documents;'\
'm:/mnt;'\
'M:/media;'\
'i:~/Documents/Личные;'\
's:~/Pictures/screenshots;'\
't:~/Downloads/torrent_downloads;'\
'w:~/Pictures/wallpapers'

# Set nnn context colors
export NNN_COLORS="2431"

# Trash (needs trash-cli) instead of delete
export NNN_TRASH=1

# Set nnn plugin shortcuts
export NNN_PLUG='b:oldbigfile;'\
'c:-chksum;'\
'd:-diffs;'\
'e:-suedit;'\
'f:-uidgid;'\
'g:-_git diff;'\
'h:-treeview;'\
'i:-imgview;'\
'j:fzcd;'\
'l:-gitlog;'\
'k:-_fuser -kiv $nnn*;'\
'm:-mp3conv;'\
'o:-fzopen;'\
'p:-_less -iR $nnn*;'\
'q:preview-tui;'\
'r:renamer;'\
's:splitjoin;'\
't:cdtolinkdir;'\
'u:-dups;'\
'v:-vidthumb'

# Use fallback opener for unknown files
export NNN_FALLBACK_OPENER=xdg-open

# Indicate that you are within a shell that will return you to nnn
[ -n "$NNNLVL" ] && PS1="$NNNLVL $PS1"

# Variable to store nnn selection
export sel=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection

# Set archive extensions to recognize
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
# ===== NNN ===== }}}
# ===== FZF ===== {{{
# fzf completion and keybindings
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash

# fzf custom command completions
_fzf_setup_completion path git exercism

# fzf default options
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

# Set default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs 2>&-'
# ===== FZF ===== }}}
# ===== systemd ==== {{{
# Make systemd aware of your modified PATH
systemctl --user import-environment PATH
# ===== systemd ==== }}}
