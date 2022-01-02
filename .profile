export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/google-chrome-stable
export SHELL=/bin/zsh

# Custom
export DOTFILES="$HOME/dotfiles"
export SCRIPTS="$HOME/scripts"
export CPDIR="$HOME/development/algorithms/competitive-programming"
export CPLIB="$HOME/development/algorithms/cp-library"
export ACLIB="$HOME/development/algorithms/ac-library"
export CPPINCLUDE="$HOME/development/resources/cppinclude"
export KEYS="$HOME/.keys"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$SCRIPTS/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
