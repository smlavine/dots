# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# load aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

export TERM="xterm-256color"

export EDITOR="nvim"

export LESSHISTFILE="/dev/null"

# Environment variables for the Go programming language
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"

# Set XDG Base Directory specification variables.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Make Rust-related data follow the XDG Base Directory specification.
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Make libdvdcss data follow the XDG Base Directory specification.
export DVDCSS_CACHE="$XDG_DATA_HOME/dvdcss"

# Add smlss scripts to $PATH
export PATH="$HOME/smlss/scripts:$PATH"

# Add .local to $PATH
export PATH="$HOME/.local/bin:$PATH"

# Add Rust executables to $PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Add Go programs to $PATH
export PATH="$GOBIN:$PATH"

# disable bash history
HISTFILE=/dev/null

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# remove files that store data when I don't want them to.
[ -f ~/.calc_history ] && rm ~/.calc_history
[ -f ~/.python_history ] && rm ~/.python_history
[ -f ~/.recently-used ] && rm ~/.recently-used

export PS1='$ '

set -o vi

# print on start of shell
pwd

