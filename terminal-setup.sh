#!/bin/bash -f

# Setup .aliases file if it does not exist.
if [ ! -f $HOME/.aliases ]; then
	touch $HOME/.aliases
	tee $HOME/.aliases >/dev/null <<'EOF'
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

# Setup .profile file if it does not exist.
if [ ! -f $HOME/.profile ]; then
	touch $HOME/.profile
	tee $HOME/.profile >/dev/null <<'EOF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.

if [ -f ~/.aliases ]; then
. ~/.aliases
fi

# Set pyenv to manage global python.
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH=$PATH:$HOME/bin # For various scripts
export PATH="~/.composer/vendor/bin:$PATH"
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
EOF
fi

if [ ! -f $HOME/.zshrc ]; then
	touch $HOME/.zshrc
	tee $HOME/.zshrc >/dev/null <<'EOF'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/bin/git-completion.zsh
fpath=(~/bin $fpath)

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

autoload -Uz compinit && compinit
EOF
fi

if [ ! -f $HOME/.bash_profile ]; then
	touch $HOME/.bash_profile
	tee $HOME/.bash_profile >/dev/null <<'EOF'

source $HOME/bin/git-completion.bash

# Auto complete sudo commands
complete -cf sudo
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
EOF
fi
