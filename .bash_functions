#!/bin/bash


# Create a directory and immediately move into it
mcd() {
  mkdir -p $1
  cd $1
}

# Change directory and list contained files
cl() {
  local dir="$1"
  local dir="${dir:=$HOME}"
  if [[ -d "$dir" ]]; then
    cd "$dir" >/dev/null; ls -lh
  else
    echo "bash: cl: $dir: Directory not found"
  fi
}

# Decompress any compressed file format
extract() {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z)        7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Compile and execute a C source on the fly
csource() {
  [[ $1 ]]    || { echo "Missing operand" >&2; return 1; }
  [[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
  local output_path=${TMPDIR:-/tmp}/${1##*/};
  gcc "$1" -o "$output_path" && "$output_path";
  rm "$output_path";
  return 0;
}

# Calculator
calc() {
  echo "scale=3;$@" | bc -l
}

# Find by name
ff() { find . -name $@ -print; }

# Kill process by name
kp() {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid  ($1) killed."
    fi
  else
    echo "None killed."
  fi
  return;
}

# Colored man
man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

# Start new ranger instance only if it is not running in current shell
r() { [ -z "$RANGER_LEVEL" ] && ranger || exit; }

# Run application in background and remove it from current shell
runb() {
    app="$1"
    $app & 
    disown
}

# Query default application
qda() {
    local path="$1"

    xdg-mime query default $(xdg-mime query filetype "$path")
}

# Set default application for file
sda() {
    local path="$1"
    local application_substr="$2"

    application="$(find -L /usr/share/applications ~/.local/share/applications -type f | awk -F'/' '{print $NF}' | grep "^$application_substr" | sort | head -n1)"

    xdg-mime default "$application" $(xdg-mime query filetype "$path") 2>&- \
    && echo "Set default application for files like \"$path\" to $application" \
    || echo "Application starting with $application_substr not found!"
}

# Set terminal emulator font on the fly
setfont() {
    OPTS=$(getopt -o nbiI --long norm,bold,italic,bold-italic -n 'parse-options' -- "$@")

    if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
    eval set -- "$OPTS"

    local NORM=710
    local BOLD=711
    local ITALIC=712
    local BOLDITALIC=713

    # Set font type as "normal" by default
    fonttype=$NORM

    while true; do
        case "$1" in
            -n ) fonttype=$NORM ; shift ;;
            -b ) fonttype=$BOLD ; shift ;;
            -i ) fonttype=$ITALIC ; shift ;;
            -I ) fonttype=$BOLDITALIC ; shift ;;
            -- ) [ "$2" ] && { font="$2"; shift 2; break; } || { echo "Font not specified!"; exit; } ;;
            * ) break ;;
        esac
    done

    echo -e "\033]$fonttype;$font\007"
}

pkgfiles() {
    yay -Qlq "$1" | grep -v "/$" | xargs -I{} du -h {} 2>&- | sort -h
}

n() {
    # Block nesting of nnn in subshells
    if [ "${NNNLVL:-0}" -ge 1 ]; then
	echo "nnn is already running"
	return
    fi

    # Unmask ^Q  (, ^V etc.)  (if required, see `stty -a`) to Quit nnn
    stty start undef
    stty stop undef

    # The default behaviour is to cd on quit  (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Run nnn and tmux if it does not exist
    cmd="/usr/bin/nnn -xra "$@""
    if [ -z "$TMUX" ]; then
	eval "tmux new $cmd"
    else
	eval "$cmd"
    fi

    if [ -f "$NNN_TMPFILE" ]; then
	. "$NNN_TMPFILE"
	rm -f "$NNN_TMPFILE" > /dev/null
    fi

    rm -f "$NNN_FIFO" > /dev/null
}

# Changes dashes to underscores for all files in current dir
dashes_to_underscore() {
    for f in $(find . -type f); do
	new_filename="$(echo "$f" | tr "-" "_")"
	mv "$f" "$new_filename"
    done
}

# Wrapper around regular diff using ydiff
diff() {
    /usr/bin/diff -u "$@" | ydiff; 
}

# List files owned by the specified package with size
pkgfiles() {
    local package="$1"
    pacman -Qlq $package | grep -v '/$' | xargs -r du -h | sort -h
}
