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

export EDITOR="nvim"

export LESSHISTFILE="/dev/null"

# Environment variables for the Go programming language
export GOPATH="$HOME/code/go"
export GOBIN="$GOPATH/bin"

# Set XDG Base Directory specification variables.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Add smlss scripts to $PATH
export PATH="$HOME/smlss/scripts:$PATH"

# Add .local to $PATH
export PATH="$HOME/.local/bin:$PATH"

# Add Rust executables to $PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Add Go programs to $PATH
export PATH="$GOBIN:$PATH"


# Display neofetch on user login. I think it looks cool, okay?
neofetch

# Run startx only if a dwm process is not already running. This allows the user
# to open a text terminal in another tty.
[ "$(ps -a | grep dwm)" ] && echo "dwm already running" || startx

