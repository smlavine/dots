#!/bin/bash

# Source personal aliases.
[ -f "$SMLSS_PERSONAL_ALIASES" ] && source "$SMLSS_PERSONAL_ALIASES"

# Alias definitions.

alias ls='ls --color=auto'
alias l='ls -CAF'
alias ll='ls -AlhF'
alias lt='ls -AlhFtr'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias info='info --vi-keys'

alias py='python3'

alias cl='clear; l'

alias v='nvim'

alias ga='git add'
alias gam="git status | grep '^[^a-z]*modified' | awk '{ print \$2 }' |
	xargs git add"
alias gb='git branch'
alias gc='git commit -ve'
alias gd='git diff'
alias gg='git grep -inF --recurse-submodules'
alias gk='git checkout'
alias gl='git log'
alias glf='git log --format=fuller'
alias gp='git push'
alias gpa='git remote | grep -v upstream | xargs -L1 git push'
alias gpl='git pull'
alias gr='git restore'
alias gra="git status | grep '^[^a-z]*modified' | awk '{ print \$2 }' |
	xargs git restore"
alias gre='git remote -v'
alias gri='git rebase -i'
alias grl='git reflog'
alias gs='git status'
alias gsl='git shortlog'
alias gsh='git show --format=fuller'
alias gt='git tag'
alias gcp='git cherry-pick'

alias m='make'
alias mc='make clean'
alias md='make debug'
alias mi='make install'

alias f='new firefox'
alias s='new sxiv'
alias x='new xournalpp'
alias z='new zathura'

alias yay='yay --sudoloop' # prevents sudo timeout on long builds

# Sums up numbers on each line in standard input
alias count='{ paste -sd+ - | bc; }'

alias sp='sudo protonvpn'

alias ..='cd ./..; pwd'
alias  d='cd ./..; pwd'
alias .2='cd ./..; pwd'
alias ...='cd ./../..; pwd'
alias .3='cd ./../..; pwd'
alias ....='cd ./../../..; pwd'
alias .4='cd ./../../..; pwd'
alias .....='cd ./../../../..; pwd'
alias .5='cd ./../../../..; pwd'
alias ......='cd ./../../../../..; pwd'
alias .6='cd ./../../../../..; pwd'
alias .......='cd ./../../../../../..; pwd'
alias .7='cd ./../../../../../..; pwd'
alias ........='cd ./../../../../../../..; pwd'
alias .8='cd ./../../../../../../..; pwd'
alias .........='cd ./../../../../../../../..; pwd'
alias .9='cd ./../../../../../../../..; pwd'

# Ascend the directory hierarchy until in a directory with .git/ in it.
# If ascended all the way to the root directory, return to the original
# location and print a failure message.
gitroot()
{
	start="$(pwd)"

	while ! [ -d .git ]; do
		cd ..
		if [ "$(pwd)" = '/' ]; then
			cd "$start"
			echo 'gitroot: failure: ascended to /' >&2
			break
		fi
	done
}

# Descend the directory hierarchy as long as there is one and only one
# directory in each directory entered.
descend()
{
	if [ "$1" ]; then
		cd "$1"
	fi

	while :; do
		directories="$(find . ! -name . -prune -type d)"
		if [ "$(echo "$directories" | wc -l)" -eq 1 ]; then
			cd "$(printf '%s' "$directories")"
		else
			break
		fi
	done
}
