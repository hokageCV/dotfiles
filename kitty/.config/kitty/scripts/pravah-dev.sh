#!/bin/bash

PROJECT_ROOT="$HOME/hokage/code/pravah"
FRONTEND="$PROJECT_ROOT/frontend"
BACKEND="$PROJECT_ROOT/backend"

kitty @ launch \
  --location=vsplit \
  --cwd="$FRONTEND" \
  --title=frontend \
  --dont-take-focus \
  "$SHELL" -c "pnpm run dev; exec $SHELL"

kitty @ launch \
  --location=vsplit \
  --cwd="$BACKEND" \
  --title=backend \
  "$SHELL" -c "pnpm run dev; exec $SHELL"
