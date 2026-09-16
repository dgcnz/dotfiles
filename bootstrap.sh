#!/usr/bin/env bash
# Set up a fresh Mac from this repo.
#
#   git clone https://github.com/dgcnz/dotfiles.git ~/development/dotfiles
#   ~/development/dotfiles/bootstrap.sh
#
# Safe to re-run: each step checks before acting, and an existing config file
# is moved aside (never deleted) before its symlink goes in.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ "$(uname -s)" == Darwin ]] || { echo "bootstrap.sh is macOS only" >&2; exit 1; }

step() { printf '\n==> %s\n' "$*"; }

# Xcode command line tools: git and compilers. Installs through a GUI dialog.
if ! xcode-select -p >/dev/null 2>&1; then
  step "Installing Xcode command line tools"
  xcode-select --install
  echo "Finish the installer dialog, then run this script again." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  step "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

step "Installing Brewfile packages"
brew bundle install --file="$DOTFILES/Brewfile"

# Symlink so edits made on the machine land back in this repo.
link() {
  local src="$DOTFILES/$1" dst="$HOME/$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    local aside
    aside="$dst.pre-dotfiles.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$aside"
    echo "moved existing $dst to $aside"
  fi
  ln -s "$src" "$dst"
  echo "linked $dst"
}

step "Linking config"
link zellij/config.kdl .config/zellij/config.kdl
link ghostty/config .config/ghostty/config

# Generated rather than versioned: lfs and nbdime write their own blocks.
step "Configuring git"
git config --global user.name "Diego Canez"
git config --global user.email "canezdiego@gmail.com"
git lfs install
nbdime config-git --enable --global
ignore="$HOME/.config/git/ignore"
mkdir -p "$(dirname "$ignore")"
touch "$ignore"
grep -qxF '**/.claude/settings.local.json' "$ignore" ||
  echo '**/.claude/settings.local.json' >>"$ignore"

# Cloned over https because there is no GitHub ssh key yet on a new machine;
# pushes still go over ssh once one is added.
if [[ ! -d "$HOME/.config/nvim" ]]; then
  step "Cloning neovim config"
  git clone https://github.com/dgcnz/kickstart.nvim.git "$HOME/.config/nvim"
  git -C "$HOME/.config/nvim" remote set-url --push origin git@github.com:dgcnz/kickstart.nvim.git
  git -C "$HOME/.config/nvim" remote add upstream https://github.com/nvim-lua/kickstart.nvim.git
fi

if ! command -v claude >/dev/null 2>&1 && [[ ! -x "$HOME/.local/bin/claude" ]]; then
  step "Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
fi

cat <<'MSG'

==> Done. Left for you, on purpose:

  Shell: add these to your shell's startup file
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export EDITOR=nvim VISUAL=nvim      # zellij's scrollback editor needs this
    export PATH="$HOME/.local/bin:$PATH"
    fzf keybindings: see `fzf --help` for your shell's init line

  SSH: copy ~/.ssh from the old Mac, or make new keys and register them
       with GitHub, the clusters and the VPS

  Log in: gh auth login, flyctl auth login, claude, codex

  Neovim: open nvim once so lazy.nvim installs the plugins
MSG
