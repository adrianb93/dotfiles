export BREW_PREFIX='/opt/homebrew'

# Setup brew
eval "$($BREW_PREFIX/bin/brew shellenv)"

# "cd" by typing only the directory
setopt autocd

# Use the terminal to enter GPG passphrase
export GPG_TTY=$(tty)

# brew autocompletions
# https://docs.brew.sh/Shell-Completion
export FPATH="$BREW_PREFIX/share/zsh/site-functions:$FPATH"

# Zsh autocompletions
# https://github.com/zsh-users/zsh-autosuggestions
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^e' autosuggest-execute
bindkey '^y' autosuggest-accept

# Zsh syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Command substring search (up / down arrows)
# https://github.com/zsh-users/zsh-history-substring-search
source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# z: jump around
# https://github.com/rupa/z/
source "$BREW_PREFIX/etc/profile.d/z.sh"

# sqlite
# https://formulae.brew.sh/formula/sqlite#default
export PATH="$BREW_PREFIX/opt/sqlite/bin:$PATH"

# sqlite
# https://formulae.brew.sh/formula/postgresql#default
export PATH="$BREW_PREFIX/opt/postgresql@13/bin:$PATH"

# GNU findutils
# https://formulae.brew.sh/formula/findutils#default
export PATH="$BREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"

# GNU coreutils
# https://formulae.brew.sh/formula/coreutils#default
export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

# GNU sed
# https://formulae.brew.sh/formula/gnu-sed#default
export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

# GNU which
# https://formulae.brew.sh/formula/gnu-which#default
export PATH="$BREW_PREFIX/opt/gnu-which/libexec/gnubin:$PATH"

# Java
export PATH="$BREW_PREFIX/opt/openjdk/bin:$PATH"

# composer
# https://formulae.brew.sh/formula/composer#default
export PATH="/Users/adrianbrown/.composer/vendor/bin:$PATH"

# locally installed composer install binaries
# https://twitter.com/paulredmond/status/1189952205182226432
export PATH="./vendor/bin:$PATH"

# fzf
# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# use 'fd' instead of 'find' for fzf file lookup
export FZF_DEFAULT_COMMAND="fd --type file --follow --no-ignore --hidden --exclude .git"

# phpactor
# https://github.com/phpactor/phpactor
export PATH="/Users/adrianbrown/.vim/plugged/phpactor/bin:$PATH"

# VIM, not nano
export VISUAL=vim
export EDITOR="$VISUAL"

# makes ls colourful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Touch noisy files that should exist
touch ~/.z
touch ~/.hushlogin

# Setup completions
autoload -Uz compinit
compinit

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
fpath=($fpath "/Users/adrianbrown/.zfunctions")

# Set typewritten ZSH as a prompt
export TYPEWRITTEN_CURSOR='terminal'
autoload -U promptinit; promptinit
prompt typewritten
fpath=($fpath "/Users/adrianbrown/.zfunctions")

# organised fun
source $HOME/.aliases
source $HOME/.functions
