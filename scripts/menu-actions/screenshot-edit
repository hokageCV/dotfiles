#!/usr/bin/env bash

tmpfile=$(mktemp /tmp/screen-XXXX.png)   

grim -g "$(slurp)" "$tmpfile"           
swappy -f "$tmpfile"                   

