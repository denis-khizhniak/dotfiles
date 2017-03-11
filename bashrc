#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source alias and functions 
. .alias &
. .function &

PS1='[\u@\h \W]\$ '

# Complete command names
complete -c man which

# Complete command names as well as file names
complete -f sudo
