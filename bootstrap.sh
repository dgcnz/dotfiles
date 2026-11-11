#!/usr/bin/env bash
# Arch/EndeavourOS setup. Run as your normal user, never with sudo.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
[[ "$(uname -s)" == Linux ]] && command -v pacman >/dev/null || {
  echo 'This bootstrap requires Arch Linux or an Arch derivative.' >&2; exit 1;
}
(( EUID != 0 )) || { echo 'Run as your normal user, without sudo.' >&2; exit 1; }

# Full upgrade avoids unsupported partial upgrades. Review pacman's prompts.
sudo pacman -Syu --needed \
  niri ghostty fuzzel mako swaylock swayidle xwayland-satellite \
  xdg-desktop-portal-gtk xdg-desktop-portal-gnome \
  pipewire wireplumber playerctl brightnessctl \
  ttf-sourcecodepro-nerd neovim zellij fzf ripgrep bat lazygit \
  git github-cli git-lfs base-devel wl-clipboard

niri validate --config "$DOTFILES/niri/config.kdl"

link_config() {
  local source="$DOTFILES/$1" target="$CONFIG_HOME/$2" backup
  mkdir -p "$(dirname "$target")"
  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    return
  fi
  if [[ -e "$target" || -L "$target" ]]; then
    backup="$(mktemp -d "${target}.pre-dotfiles.XXXXXX")"
    mv "$target" "$backup/original"
    printf 'Backed up %s to %s/original\n' "$target" "$backup"
  fi
  ln -s "$source" "$target"
  printf 'Linked %s\n' "$target"
}

link_config ghostty/config ghostty/config
link_config zellij/config.kdl zellij/config.kdl
mkdir -p "$CONFIG_HOME/nvim" "$HOME/Pictures/Screenshots"
# Clone only into a missing or empty directory; preserve existing Neovim setup.
if [[ -z "$(ls -A "$CONFIG_HOME/nvim")" ]]; then
  git clone https://github.com/dgcnz/kickstart.nvim.git "$CONFIG_HOME/nvim"
  git -C "$CONFIG_HOME/nvim" remote set-url --push origin git@github.com:dgcnz/kickstart.nvim.git
  git -C "$CONFIG_HOME/nvim" remote add upstream https://github.com/nvim-lua/kickstart.nvim.git
fi
# Link Niri last: an active session reloads it immediately.
link_config niri/config.kdl niri/config.kdl

cat <<'MSG'

Done. Log out and select Niri at login (Plasma remains available).
If already in Niri, log out and back in to start notifications and idle locking.

Super+T: Ghostty     Super+D: launcher       Super+Q: close window
Super+H/J/K/L: focus Super+Shift+F: fullscreen Super+Shift+/: shortcut help
Super+Alt+L: lock    Super+Shift+E: log out

Shell setup is left to you: export EDITOR=nvim VISUAL=nvim
Slack and your browser are not installed by this script; use your existing apps.
Check audio, Slack calls/screen sharing, and locking after login.
Existing configs are saved beside their replacements in .pre-dotfiles directories.
MSG
