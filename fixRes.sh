#!/bin/bash

# Old settings - 1 Acer 23inch display and built in display
#xrandr -q
#xrandr --addmode eDP-1 1920x1080
#xrandr --output  eDP-1 --mode 1920x1080
#xrandr --addmode DP-3  1920x1080
#xrandr --output  DP-3  --mode 1920x1080
#arandr

# New settings - 2 Acer displays and built in display
xrandr -q
xrandr --addmode eDP-1 1920x1080
xrandr --output  eDP-1 --mode 1920x1080
xrandr --addmode DP-1-1 1920x1080
xrandr --output  DP-1-1 --mode 1920x1080
xrandr --addmode DP-1-3 1920x1080
xrandr --output  DP-1-3 --mode 1920x1080
arandr
