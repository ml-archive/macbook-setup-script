#!/usr/bin/env bash

echo "${GREEN}Setting up... ${BROWN}rvm...${NC}"

# RVM doesn't work in posix mode. If we loaded this script using "sh" posix is enabled by default.
# See: https://github.com/rvm/rvm/pull/836#issuecomment-4538762
if [[ -n "${BASH_VERSION:-}" ]] && [[ ":${SHELLOPTS:-}:" == *":posix:"* ]]; then
  echo "${YELLOW}POSIX mode detected. RVM will not work in POSIX mode...${NC}"
  set +o posix
  echo "${YELLOW}POSIX Disabled${NC}"
fi

brew install gnupg gnupg2

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby --ignore-dotfiles

echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*' >> ${HOME}/.bash_profile
source $HOME/.rvm/scripts/rvm

rvm -v
ruby -v
