# dotfiles

Setup for a fresh Mac. Bootstrap adds Homebrew to `~/.zprofile`; other shell
preferences are not managed.

```
git clone https://github.com/dgcnz/dotfiles.git ~/development/dotfiles
~/development/dotfiles/bootstrap.sh
```

- `Brewfile`: packages and apps
- `dock.sh`: pins Finder, Settings, Clock, Calendar, Mail, and Ghostty in order;
  hides recent apps and preserves folders/stacks. Run with `bash dock.sh`.
- `bootstrap.sh`: installs Homebrew and the Brewfile, links the configs below,
  sets up git, clones [kickstart.nvim](https://github.com/dgcnz/kickstart.nvim),
  installs Claude Code, then prints what is left to do by hand
- `zellij/`, `ghostty/`: symlinked into `~/.config`
- `launchagents/`: Caps Lock → Escape mapping, applied by bootstrap and at login
  using macOS's built-in `hidutil`. The Escape key keeps its normal behavior.

The old Linux setups live on the `manjaro` and `manjaro-i3` branches.
