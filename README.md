# dotfiles

Setup for a fresh Mac. Shell config is deliberately not included.

```
git clone https://github.com/dgcnz/dotfiles.git ~/development/dotfiles
~/development/dotfiles/bootstrap.sh
```

- `Brewfile`: packages and apps
- `bootstrap.sh`: installs Homebrew and the Brewfile, links the configs below,
  sets up git, clones [kickstart.nvim](https://github.com/dgcnz/kickstart.nvim),
  installs Claude Code, then prints what is left to do by hand
- `zellij/`, `ghostty/`: symlinked into `~/.config`

The old Linux setups live on the `manjaro` and `manjaro-i3` branches.
