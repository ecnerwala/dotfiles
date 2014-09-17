#!/bin/bash

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && /etc/xprofile
[ -f ~/.xprofile ] && ~/.xprofile

DEFAULTSESSION=i3

case "$1" in 
	i3) exec i3 ;;
	*) exec  $DEFAULTSESSION ;;
esac
