# Install

You can choose two different setups either RVM, or rbenv.

NOTE: rbenv cannot work with rvm installed so if you have RVM installed you will need to remove it.

### rvm

[RVM](https://rvm.io) is the acronym of Ruby enVironment Manager. It manages Ruby application environments and enables switching between them.

### rbenv

[rbenv](https://github.com/rbenv/rbenv) is short for Ruby Environment. It’s a different command line tool that enables you to quickly and easily switch between different rubies installed on your system.

What I like about rbenv is it’s simplicity and obviousness. It might look especially familiar for those coming from Python background, because rbenv, in fact, looks a lot like pyenv — a python version manager forked from rbenv and modified for Python.

rbenv is easy in development. All you need is to create a .ruby-version file in a directory and from that moment the version specified in this file will be used in this particular directory.

It bundles greatly with Bundler. In fact, bundler takes care of gem management completely. Each installation of Ruby gets its own installation of bundler. Installation can be configured so that it reuses gems for projects that utilize same Ruby version. Otherwise, gemsets are installed on per-project basis.

rbenv works by introducing a directory full of small executables called shims into your path. The path to this directory looks like this: /Users/user/.rbenv/shims. Each shim is a tiny Bash script that has the exact same name as any Ruby interpreter based tool in your system.

For example, before calling the actual Jekyll executable, a shim will check the .ruby-version files and RBENV_VERSION environmental variable as well as global ~/.rbenv/version file if other options did not work. Shim will then pull out a correct version of Jekyll according to your specified Ruby version. To be able to do that, the directory with shims is placed first in the $PATH. This way any call to Jekyll in our case will be at first directed to a shim.

Let’s take a look at how a user would use rbenv.



Reference: https://duseev.com/articles/rbenv-vs-rvm/
Reference: https://gorails.com/setup/osx/10.14-mojave#ruby
