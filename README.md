Fuzz Setup Script
==================

## Goal

Provide a standardized development environment for all Fuzz web developers, optimized to run our applications in a consistent way.

## Current State

Does the following:

- Configures Emacs to not leave temp files all around your filesystem
- Sets the default Terminal theme to Pro and binds the Option key as Meta
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
  - pkg-config
  - PCRE
  - Dnsmasq
- Installs pip (Python package manager)
- Installs AWS command line tools
- Installs Composer
- Installs XQuartz
- Sets up a local hosting environment in ~/Sites
- Installs Node.js
- Prompts you to set up a global .gitconfig
- Sets up a starter global .gitignore
- Sets the hostname to localhost
- Configures a local DNS resolver to send all *.localhost to 127.0.0.1
- Installs Sequel Pro
- Installs Slack
- Install latest Java JDK
- Install latest versions of all browsers


## TODO:
- Add default dock
- Install the legacy JDK IntelliJ products needs
- Automate GitLab setup
- Set date.timezone to America/New_York in /etc/php.ini
- …and more!
