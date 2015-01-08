Fuzz Setup Script
==================

## Goal

Provide a standardized development environment for all Fuzz web developers, optimized to run our applications in a consistent way.

## Current State

Does the following:

- Configures Emacs to not leave temp files all around your filesystem
- Sets the default Terminal theme to Pro and binds the Option key as Meta
- Installs a shortcut so ⌘⇧M runs the Window > Zoom menu option in all applications
- Installs XCode Command Line Tools (including git, gcc, etc.)
- Installs Homebrew and installs/configures the following packages:
  - ImageMagick
  - Ghostscript
  - GNU autoconf
  - MySQL server
  - Redis server
  - Beanstalkd server
  - PDF manipulation tools:
    - Poppler
    - PDFTK
  - Mcrypt
  - pkg-config
  - PCRE
  - Dnsmasq
- Installs pip (Python package manager)
- Installs AWS command line tools
- Gives the current user full control over /usr/local
- Installs Composer
- Installs XQuartz
- Sets up a local hosting environment in ~/Sites
- Compiles and enables the following PHP extensions into the system installation of PHP:
  - mcrypt
  - pcntl
  - imagick
- Configures Apache, PHP, and MySQL for local development
- Installs PEAR and PECL
- Installs Node.js and globally installs the following packages:
  - Bower
  - ESLint
  - Protractor
  - Karma
- Installs RVM, latest stable Ruby, and the following gems:
  - Compass
  - Rails
  - SCSS Lint
- Prompts you to set up a global .gitconfig
- Sets up a starter global .gitignore
- Sets the hostname to localhost
- Configures a local DNS resolver to send all *.localhost to 127.0.0.1
- Installs Sequel Pro



## TODO:
- @todo
