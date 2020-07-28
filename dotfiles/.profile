# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Add smlss scripts and suckless utilities to path in smlss folder
export PATH="$HOME/smlss/scripts:$PATH"
for d in $HOME/smlss/suckless/*;
do
    export PATH="$d:$PATH"
done

export EDITOR="nvim"

# add .local to $PATH
export PATH="$HOME/.local/bin:$PATH"

# variables for the Go programming language
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# add Rust stuff to $PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Startup things

neofetch
# startx only if a dwm process is not already running.
[ "$(ps -a | grep dwm)" ] && echo "dwm already running" || startx

