#!/bin/sh

USER_RESOURCES_PATH=$HOME/.Xresources
USER_MODMAP_PATH=$HOME/.Xmodmap
SYS_RESOURCES_PATH=/etc/X11/xinit/.Xresources
SYS_MODMAP_PATH=/etc/X11/xinit/.Xmodmap


# System Level Setting
# ====================
if [ -f "$SYS_RESOURCES_PATH" ]; then
    xrdb -merge "$SYS_RESOURCES_PATH"
fi

if [ -f "$SYS_MODMAP_PATH" ]; then
    xmodmap "$SYS_MODMAP_PATH"
fi

# User Level Setting
# ==================
if [ -f "$USER_RESOURCES_PATH" ]; then
    xrdb -merge "$USER_RESOURCES_PATH"
fi

if [ -f "$USER_MODMAP_PATH" ]; then
    xmodmap "$USER_MODMAP_PATH"
fi

# ESSENTIAL BLOCK
# ===============
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


# Start Window Manager
# ====================
exec i3
