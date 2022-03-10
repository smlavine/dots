.POSIX:

all: install

install:
	# First, create any necessary directories.
	# awk is used to prepend $HOME instead of sed to avoid sed's delimiter
	# collision.
	find src -mindepth 1 -type d | sed 's/^src//' | \
		awk -v home="$(HOME)" '{ print home $$0 }' | \
		xargs mkdir -pv
	# Next, copy all files to their locations in $HOME.
	# 'sed p' repeats each line. The awk command prepends $HOME to make a
	# path to the file's destination. The paste command combines the two
	# lines together.
	find src -mindepth 1 -type f | sed p | \
		awk -v home="$(HOME)" \
		'NR%2==1 { print "cp -v -T " $$0 } \
		NR%2==0 { sub("^src",""); print home $$0 }' | \
		paste -d' ' - - | sh

uninstall:
	# The order of commands is reversed from that in install, because we
	# only want to remove empty directories, for safety's sake.
	find src -mindepth 1 -type f | \
		awk -v home="$(HOME)" \
		'{ sub("^src",""); print "rm -v " home $$0 }' | sh
	# Child directories echo first (-depth) so that parent directories are
	# emptied before removed.
	find src -mindepth 2 -type d -depth | sed 's/^src//' | \
		awk -v home="$(HOME)" '{ print home $$0 }' | \
		xargs rmdir -v

.PHONY: all install uninstall
