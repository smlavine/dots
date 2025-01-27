#!/bin/bash

# Environment variable definitions.

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export PAGER="less"

# If in a git repo, print the branch name in magenta before a '$' in green.
# Ex: 'master$ '
export PS1="\[\033[01;35m\]\$(git symbolic-ref --short HEAD 2>&-)\[\033[01;32m\]$\[\033[00m\] "

# Alternate: 'user@hostname:~$ ' but with some color in it
#export PS1='\[\033[01;32m\]\u\[\033[01;31m\]@\[\033[01;36m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$\[\033[00m\] '

# Disable less history
export LESSHISTFILE="/dev/null"

# Go programming language
export GOPATH="$HOME/Code/go"
export GOBIN="$GOPATH/bin"

# Set XDG Base Directory specification variables.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Env vars used by Navipage.
export NAVIPAGE_DIR="$XDG_DATA_HOME/navipage"
export NAVIPAGE_SH="$XDG_CONFIG_HOME/navipage/start.sh"

# Make Rust-related data follow the XDG Base Directory specification.
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Make libdvdcss data follow the XDG Base Directory specification.
export DVDCSS_CACHE="$XDG_DATA_HOME/dvdcss"

# Make ncurses (terminfo) data follow the XDG Base Directory specification.
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Make pass data follow the XDG Base Directory specification.
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# See <https://git.sr.ht/~smlavine/scripts/tree/master/item/src/mypassmenu>.
export MYPASSMENU_WEIGHTS="$XDG_DATA_HOME/mypassmenu.tsv"

# Make bash-completion follow the XDG Base Directory specification.
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash_completion"

# Make weechat follow the XDG Base Directory specification.
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

# A directory to hold files that are accessed by smlss-adjacent processes or
# aliases, or are otherwise used by the user of smlss.
export SMLSS_DATA_DIR="$XDG_DATA_HOME/smlss"

# A file that can hold aliases that are not part of the main smlss aliases
# file. It is intended for aliases that are specific and need not be shared or
# kept in version control.
export SMLSS_PERSONAL_ALIASES="$SMLSS_DATA_DIR/myaliases"

# This is where I store my screenshots.
export SCREENSHOT_DIR="$HOME/Documents/pictures/screenshots/"

# Add .local to $PATH
export PATH="$HOME/.local/bin:$PATH"
# Add Rust executables to $PATH
export PATH="$HOME/.cargo/bin:$PATH"
# Add Go programs to $PATH
export PATH="$GOBIN:$PATH"
# Add Ruby programs to $PATH
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
# Add diff-highlight special path if it exists
if [ -d /usr/share/git/diff-highlight ]; then
        export PATH="/usr/share/git/diff-highlight:$PATH"
fi

# Fix broken Java GUIs
# https://wiki.archlinux.org/title/Java#Gray_window,_applications_not_resizing_with_WM,_menus_immediately_closing
export _JAVA_AWT_WM_NONREPARENTING=1

export TZDIR="/usr/share/zoneinfo"

# Add sonar-scanner related values
# https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
export SONAR_SCANNER_HOME="/opt/sonar-scanner"
export PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

export SUDO_ASKPASS="$(which askpass)"
