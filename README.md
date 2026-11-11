# dotfiles — Arch + Niri

Keyboard-first Arch/EndeavourOS desktop, with the same Ghostty and Zellij
preferences as my Mac. The `macos` branch remains the Mac setup; older Linux
setups are on `manjaro` and `manjaro-i3`.

```sh
git clone --branch arch-niri https://github.com/dgcnz/dotfiles.git ~/development/dotfiles
cd ~/development/dotfiles
./bootstrap.sh
```

Run as your normal user. The script requests sudo for a full system upgrade and
package installation, with normal pacman confirmation prompts. It installs the
Niri session and desktop utilities, Ghostty, the SauceCodePro Nerd Font, Zellij,
Neovim and basic CLI tools. No AUR helper or AUR packages are required.

It symlinks the three versioned configs into `${XDG_CONFIG_HOME:-~/.config}`.
Existing files, directories, and symlinks are backed up beside each target in a
unique `.pre-dotfiles.*` directory. Running it again preserves existing correct
links. Neovim's separate `dgcnz/kickstart.nvim` repo is cloned only when its config
directory is empty or absent. Git identity and shell startup files are untouched.

## Desktop

Log out and select **Niri** in the login screen. Keep Plasma available as a
fallback. If bootstrapping from Niri, config changes reload immediately, but log
out and back in to start startup services. There is no panel; use the launcher.

| Shortcut | Action |
| --- | --- |
| Super+T | Ghostty |
| Super+D | App launcher |
| Super+H/J/K/L or arrow keys | Focus windows/columns |
| Super+Ctrl+H/J/K/L | Move windows/columns |
| Super+1…9 | Focus workspace |
| Super+Q or Super+Shift+Q | Close window |
| Super+F | Toggle full-width column |
| Super+Shift+F | Toggle fullscreen |
| Super+R | Cycle column width |
| Super+O | Overview |
| Super+Alt+L | Lock screen |
| Super+Shift+/ | Shortcut help |
| Super+Shift+E | Log out (confirmation) |

Niri config is based on the installed 26.04 defaults, with Ghostty and its help
label corrected, no Waybar autostart, notifications, and locking after ten idle
minutes and before sleep. Monitor and GPU selection remain automatic: this PC's
AMD iGPU drives the display and NVIDIA is used for compute. No NVIDIA workarounds
are applied. Caps Lock and other keyboard mappings remain at system defaults.

Ghostty uses Pencil Light, SauceCodePro Nerd Font, and size 13; Zellij uses
Pencil Light with startup tips disabled. Zellij is not launched automatically.

## After setup

- Use your existing browser and Slack installation; these are not installed here.
- Check notifications, audio, calls, screen sharing, and screen locking.
- Open Neovim once to let its plugin manager install plugins.
- Set `export EDITOR=nvim VISUAL=nvim` in your shell configuration if desired.
- Keep the checkout in place: the live configs are symlinks into it.

To restore a previous config, remove its symlink and move the corresponding
`.pre-dotfiles.*/original` back to the original path. Niri reloads configuration
when saved; startup-service changes require a new session.

The inherited `Brewfile`, `dock.sh`, `bootstrap-macos.sh`, and `launchagents/`
are retained as references from the Mac branch and are not used by Linux setup.
