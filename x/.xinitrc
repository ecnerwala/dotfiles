# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


DEFAULTSESSION=i3

case "$1" in 
	i3-with-shmlog) exec i3-with-shmlog ;;
	i3) exec i3 -V -d all >~/i3log-$(date +'%F-%k-%M-%S') 2>&1 ;;
	*) exec  $DEFAULTSESSION ;;
esac
