# Load path alterations
if [ -f ~/.path_alterations ]; then
  . ~/.path_alterations
fi

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# http://engineering.appfolio.com/appfolio-engineering/2016/6/17/configuring-ruby-on-macos-with-openssl
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:/usr/local/lib/pkgconfig

# alias git to hub
eval "$(hub alias -s)"

# load variables I don't want everybody to see when they look at my bash_profile
if [ -f ~/.bash_variables ]; then
  . ~/.bash_variables
fi

# load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# pretty colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
