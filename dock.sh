#!/usr/bin/env bash
# Reapply the pinned Dock apps. Finder is always first automatically.
set -euo pipefail

apps=(
  "/System/Applications/System Settings.app"
  "/System/Applications/Clock.app"
  "/System/Applications/Calendar.app"
  "/System/Applications/Mail.app"
  "/Applications/Ghostty.app"
)

command -v dockutil >/dev/null
for app in "${apps[@]}"; do
  [[ -d "$app" ]] || { echo "Missing Dock app: $app" >&2; exit 1; }
done

# Keep folders/stacks in the other section. Save the current settings first.
backup="$HOME/.local/state/dotfiles"
mkdir -p "$backup"
defaults export com.apple.dock "$backup/dock.$(date +%Y%m%d%H%M%S).plist"
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock show-recents -bool false
for app in "${apps[@]}"; do
  dockutil --add "$app" --no-restart
done
killall Dock || true
