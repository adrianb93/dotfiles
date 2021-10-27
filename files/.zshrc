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
alias sqlite="sqlite3"

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

# bat, not cat 🦇
# https://github.com/sharkdp/bat
alias cat="bat"
export BAT_THEME="Dracula"

# VIM, not nano
export VISUAL=vim
export EDITOR="$VISUAL"
alias ":q"="exit"

# Easy update for dotfiles
update() {
    bash $HOME/Code/dotfiles/install
    brew cu
}

# SSH keys
alias sshgen='ssh-keygen -t ed25519'
alias sshkey='pbcopy < ~/.ssh/id_ed25519.pub'

# Emotes
alias shrug="echo '¯\_(ツ)_/¯' | tr -d '\n' | pbcopy; echo '¯\_(ツ)_/¯'";

# Laravel Artisan
alias artisan='php artisan'

# PHP
alias php70='valet use php@7.0'
alias php71='valet use php@7.1'
alias php72='valet use php@7.2'
alias php73='valet use php@7.3'
alias php74='valet use php@7.4'
alias php80='valet use php@8.0'
alias php81='valet use php@8.1'

# Testing
alias pest='vendor/bin/pest'
alias phpspec='vendor/bin/phpspec'
alias phpunit='vendor/bin/phpunit'
alias phpstan='vendor/bin/phpstan'
alias phpcs='vendor/bin/php-cs-fixer'
alias phpl="find . -type f -name '*.php' -not -path '*vendor/*' -print0 | xargs -0 -n1 -P8 php -l |grep 'PHP Parse error'"
test() {
    (php artisan) > /dev/null
    if [ $? -eq 0 ]; then
        php artisan test "$@"
        return
    fi
    if [ -f vendor/bin/pest ]; then
        vendor/bin/pest "$@"
    elif [ -f vendor/bin/phpunit ]; then
        vendor/bin/phpunit "$@"
    else
        phpunit "$@"
    fi
}

# Jira
function jira() {
    TICKET_NUMBER=${${1}##DEV-}

    if [ -z "${TICKET_NUMBER}" ]; then
        TICKET_NUMBER=$(git symbolic-ref HEAD 2>/dev/null | cut -d/ -f4 | cut -d- -f2)
    fi

    if [ -n "${TICKET_NUMBER}" ]; then
        open "https://xxxxxx.atlassian.net/browse/DEV-${TICKET_NUMBER}"
    else
        open "https://xxxxxx.atlassian.net/secure/RapidBoard.jspa?rapidView=6&projectKey=DEV&view=planning.nodetail&quickFilter=22&quickFilter=24&epics=visible&issueLimit=100"
    fi
}

# Open database based on Laravel env variables.
function opendb () {
    [ ! -f .env ] && { echo "No .env file found."; exit 1; }

    DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
    DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
    DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
    DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
    DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")
    DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2- | tr -d '"' | tr -d "'")

    if [ "$DB_CONNECTION" != "mysql" ] && [ "$DB_CONNECTION" != "pgsql" ] && [ "$DB_CONNECTION" != "sqlite" ]; then
        DB_CONNECTION='mysql'
    fi

    DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

    echo "Opening ${DB_URL}"
    open $DB_URL
}

# Pretty List Records
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls -GFh'
alias ll='ls -lG'

# Reset to last commit and remove untracked files and directories.
alias nah='git reset --hard; git clean -df'

# Setup completions
autoload -Uz compinit
compinit

# Touch noisy files that should exist
touch ~/.z
touch ~/.hushlogin

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
fpath=($fpath "/Users/adrianbrown/.zfunctions")

# Set typewritten ZSH as a prompt
export TYPEWRITTEN_CURSOR='terminal'
autoload -U promptinit; promptinit
prompt typewritten
fpath=($fpath "/Users/adrianbrown/.zfunctions")
