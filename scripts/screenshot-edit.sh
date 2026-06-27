#!/usr/bin/env bash

mkdir -p ~/Pictures/screenshots
tmpfile=$(mktemp /tmp/screen-XXXX.png)   

grim -g "$(slurp)" "$tmpfile"           
satty --filename "$tmpfile"                   

