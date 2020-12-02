#!/bin/sh
#
# ~/.xinitrc
#

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  	[ -x "$f" ] && . "$f"
 	done
 	unset f
fi

# Activate NumLock
numlockx &

# Start the gnome-keyring-daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &
export SSH_AUTH_SOCK

# Set wallpaper
~/.fehbg &

# Start screensaver
xscreensaver -no-splash &

# Set mouse sensivity
# xinput --set-prop 11 --type=float 'libinput Accel Speed' -0.85  # Set MOSART Semi. 2.4G Wireless Mouse

# Start polkit authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Solve a rendering issue of Java GUIs
wmname LG3D &

# Start compositor
#compton --config ~/.compton.conf -b

# Set mouse pointer to arrow
xsetroot -cursor_name left_ptr &

# Set Multi_key (for ex. to enter less-used characters)
setxkbmap -option compose:ralt &

# Network Manager applet
nm-applet &

# Start some services 
systemctl --user start notify-low-battery

# Run window manager
exec bspwm 2>/var/log/bspwm.log
