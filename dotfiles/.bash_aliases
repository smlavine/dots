#!/bin/bash

# Alias definitions.

alias ls='ls --color=auto'
alias l='ls -CAF'
alias ll='ls -AlhF'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias py='python3'

alias cl='clear; l'

# Sorted list of biggest files/directories in current directory. Only lists
# items in current directory -- that's what the grep does (removing anything
# with more than one directory level to it)
alias dh="du -h | sort -h | grep -v '.*/.*/.*'"

alias v='nvim'
alias vi='nvim'
alias ed='ed -p:'

alias r='ranger'

alias f='firefox'
alias z='zathura'

# Sums up numbers on each line in standard input
alias count='paste -sd+ - | bc'

