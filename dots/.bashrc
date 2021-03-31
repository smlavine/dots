# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source aliases file (which sources env_vars).
[ -f ~/.config/bash/aliases ] && . ~/.config/bash/aliases

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

# enable custom dircolors
[ -x /usr/bin/dircolors ] &&
	test -r "$XDG_CONFIG_HOME/dircolors" &&
	eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors")" \
|| eval "$(dircolors -b)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# tab-expand variables (ex. $SMLSS_DIR) with directories.
shopt -s direxpand

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"

# remove files that store data when I don't want them to.
[ -f ~/.calc_history ] && rm ~/.calc_history
[ -f ~/.python_history ] && rm ~/.python_history
[ -f ~/.recently-used ] && rm ~/.recently-used

# disable bash history
unset HISTFILE

# enable vi editing mode
set -o vi

# print on start of shell
pwd
l
