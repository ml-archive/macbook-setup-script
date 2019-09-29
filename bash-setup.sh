#!/bin/bash -f

# Copy over git completion file.
if [ ! -f $HOME/.git-completion.bash ]; then
    cp ./.git-completion.bash $HOME/.git-completion.bash
fi


# Setup .bash_aliases file if it does not exist.
if [ ! -f $HOME/.bash_aliases ]; then
	touch $HOME/.bash_aliases
	tee $HOME/.bash_aliases >/dev/null <<'EOF'
# Custom Aliases go here

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
# Color for ls
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# PHP Aliases
alias artisan='php artisan'
alias phpunit='vendor/bin/phpunit'

# Python Aliases
alias manpy='./manage.py'

# Networking Aliases
alias netip='ipconfig getifaddr en0'
EOF

fi

# Setup .bash_profile file if it does not exist.
if [ ! -f $HOME/.bash_profile ]; then
	touch $HOME/.bash_profile
	tee $HOME/.bash_profile >/dev/null <<'EOF'
source $HOME/.git-completion.bash

# Auto complete sudo commands
complete -cf sudo

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH=$PATH:$HOME/bin # For various scripts
export PATH="~/.composer/vendor/bin:$PATH"
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
EOF
fi
