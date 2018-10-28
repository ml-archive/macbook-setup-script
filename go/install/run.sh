#!/usr/bin/env bash

# This will setup go.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}go...${NC}"
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"

brew install go
go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint
go get golang.org/x/tools/cmd/vet
