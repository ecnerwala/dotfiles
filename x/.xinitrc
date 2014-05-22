#!/bin/bash

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && /etc/xprofile
[ -f ~/.xprofile ] && ~/.xprofile

DEFAULTSESSION=startkde

case "$1" in 
	startkde) exec startkde ;;
i3) exec i3 ;;
*) exec  $DEFAULTSESSION ;;
esac
