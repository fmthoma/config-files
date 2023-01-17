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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi
if [ -d "$HOME/config-files/bin" ] ; then
    PATH="$HOME/config-files/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.ghcup/bin" ]; then
    PATH="$HOME/.ghcup/bin:$PATH"
fi

export EDITOR=vim
export PAGER=less

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]
    then . "$HOME/.nix-profile/etc/profile.d/nix.sh"
else
    export NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/$(id -un)/channels/nixpkgs:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/$(id -un)/channels
fi

export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

export TERMINFO=/etc/terminfo
