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
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# Display neofetch on user login. I think it looks cool, okay?
neofetch

# If KDE Plasma is not yet running, start KDE Plasma.
# If KDE Plasma is already running, start dwm.
# If dwm is already running, do nothing.
if [ ! "$(ps -a | grep startplasma)" ]; then
    startplasma-wayland
elif [ ! "$(ps -a | grep dwm)" ]; then
    startx  # dwm
else
    echo 'dwm already running'
fi
