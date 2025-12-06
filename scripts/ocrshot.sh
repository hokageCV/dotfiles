#!/usr/bin/env bash
tmp=/tmp/ocrshot.png
grimshot save area "$tmp"
tesseract "$tmp" stdout | wl-copy
notify-send "OCR copied to clipboard"
