#!/usr/bin/env bash
set -euo pipefail
if (( EUID == 0 )); then
    echo "Run as your normal user; this script requests sudo where needed." >&2
    exit 1
fi
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[[ "$(uname -sm)" == "Linux x86_64" ]] || {
    echo 'This installer currently supports x86_64 Linux only.' >&2; exit 1;
}
for dependency in curl unzip; do
    command -v "$dependency" >/dev/null || {
        echo "Missing $dependency; install it with pacman first." >&2; exit 1;
    }
done
# Pin the official Niri build for reproducible installs.
XREMAP_VERSION=0.15.18
if [[ ! -x "$HOME/.local/bin/xremap" ]] || [[ "$("$HOME/.local/bin/xremap" --version)" != "xremap $XREMAP_VERSION" ]]; then
    workdir="$(mktemp -d)"
    trap 'rm -rf "$workdir"' EXIT
    curl --fail --location --proto '=https' --tlsv1.2 \
        "https://github.com/xremap/xremap/releases/download/v${XREMAP_VERSION}/xremap-linux-x86_64-niri.zip" \
        -o "$workdir/xremap.zip"
    unzip -q "$workdir/xremap.zip" -d "$workdir"
    install -Dm755 "$workdir/xremap" "$HOME/.local/bin/xremap"
fi
"$HOME/.local/bin/xremap" --validate-config "$DOTFILES/xremap/config.yml"
link_config() {
    local source="$DOTFILES/$1" target="$HOME/.config/$2" backup
    mkdir -p "$(dirname "$target")"
    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then return; fi
    if [[ -e "$target" || -L "$target" ]]; then
        backup="$(mktemp -d "${target}.pre-dotfiles.XXXXXX")"
        mv "$target" "$backup/original"
        printf 'Backed up %s to %s/original\n' "$target" "$backup"
    fi
    ln -s "$source" "$target"
}
link_config xremap/config.yml xremap/config.yml
link_config systemd/user/xremap.service systemd/user/xremap.service
# Required to read keyboard events and emit remapped events as your user.
sudo -v
sudo gpasswd -a "$(id -un)" input
printf '%s\n' 'KERNEL=="uinput", GROUP="input", TAG+="uaccess", MODE:="0660", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-xremap-uinput.rules >/dev/null
printf '%s\n' uinput | sudo tee /etc/modules-load.d/xremap-uinput.conf >/dev/null
sudo modprobe uinput
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=misc --sysname-match=uinput
systemctl --user daemon-reload
printf '%s\n' 'Setup complete. Reboot to activate input-group membership; Niri will start xremap automatically.'
