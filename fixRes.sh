#!/bin/bash
xrandr -q
xrandr --addmode eDP-1 1920x1080
xrandr --output  eDP-1 --mode 1920x1080
xrandr --addmode DP-3  1920x1080
xrandr --output  DP-3  --mode 1920x1080
arandr
