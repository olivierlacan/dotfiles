# Profile boot time
# zmodload zsh/zprof

# NOTE: uncomment to debug both commands and variable values
# set -x

# NOTE: uncomment to display executed commands 
# set -v

# Custom Git ZSH prompt
autoload -U colors && colors
# git completion
autoload -Uz compinit && compinit

# Load my custom aliases
# IMPORTANT: this needs to be first otherwise functions
# defined in it can't be used below (like pathafter) 
if [ -f ~/.dotfiles/zsh/.aliases.zsh ]; then
  source ~/.dotfiles/zsh/.aliases.zsh
fi

# Fix iTerm's dumb word jump
# https://apple.stackexchange.com/a/365225/15253
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# Get ZSH to stop assuming a word boundary with special characters in it 
# is a WHOLE word boundary
# via: https://unix.stackexchange.com/a/258661/65663
# autoload -U select-word-style
# select-word-style bash
#
# ^ above doesn't work so: 
# https://stackoverflow.com/a/11200998/385622
# Default: WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
WORDCHARS=

# Homebrew
# I didn't ask you to update everything for fuck's safe
export HOMEBREW_NO_AUTO_UPDATE=1

# AutoJump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Sublime 
pathafter "/Applications/Sublime Text.app/Contents/SharedSupport/bin"

# rbenv/ruby
pathbefore "$HOME/.rbenv/bin"
eval "$(rbenv init -)"

# NOTE: Ruby appears to not support OpenSSL 3.0 yet: 
# https://stackoverflow.com/a/70699541/385622
# Change back to openssl when it does
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# pathbefore "$PYENV_ROOT/bin/"
# eval "$(pyenv init --path)"

# pyenv-virtualenv
# eval "$(pyenv virtualenv-init -)"

phpdir=$(brew --prefix php@8.1)
pathbefore "$phpdir/bin"
pathbefore "$phpdir/sbin"
export LDFLAGS="$LDFLAGS -L$phpdir/lib"
export CPPFLAGS="$CPPFLAGS -I$phpdir/include"

bzipdir=$(brew --prefix bzip2)
pathbefore "$bzipdir/bin"
export LDFLAGS="$LDFLAGS -L$bzipdir/lib"
export CPPFLAGS="$CPPFLAGS -I$bzipdir/include"

libxmldir=$(brew --prefix libxml2)
export LDFLAGS="$LDFLAGS -L$libxmldir/lib"
export CPPFLAGS="$CPPFLAGS -I$libxmldir/include"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$libxmldir/lib/pkgconfig"

libiconvdir=$(brew --prefix libiconv)
export LDFLAGS="$LDFLAGS -L$libiconvdir/lib"
export CPPFLAGS="$CPPFLAGS -I$libiconvdir/include"

# openssl
# openssldir=$(brew --prefix openssl@1.1)
# pathbefore "$openssldir/bin"
# export LDFLAGS="$LDFLAGS -L$openssldir/lib"
# export CPPFLAGS="$CPPFLAGS -I$openssldir/include"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$openssldir/lib/pkgconfig"

# Homebrew-installed Scala
scaladir=$(brew --prefix scala@2.12)
pathbefore "$scaladir/bin"

# Homebrew-installed Java
openjdkdir=$(brew --prefix openjdk@11)
pathbefore "$openjdkdir/bin"
export CPPFLAGS="$CPPFLAGS -I$openjdkdir/include"

# Volta/Node
export VOLTA_HOME="$HOME/.volta"
pathbefore "$VOLTA_HOME/bin:"
pathbefore "$HOME/.nodenv/bin"
eval "$(nodenv init -)"

# # prompt with ruby version
# # rbenv version | sed -e 's/ .*//'
# function rbenv_ps1 (){
#   rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
# }

# # prompt with ruby version
# # rbenv version | sed -e 's/ .*//'
# function current_git_branch (){
#   ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
#   printf "${ref#refs/heads/}"
# }

# function current_git_user (){
#   git config --get user.name | sed -e "s/\//\&/g"
# }

# function current_path (){
#   echo $(basename "`pwd`")
# }

# # http://en.wikipedia.org/wiki/Tput#Usage for color codes
# function branch_if_repo (){
# 	autoload colors && colors
# 	if [ -f `which git` ] && [ -f `which rbenv` ] && [ -d ./.git ]; then
# 	  printf "%F{yellow} on %F{green}$(__current_git_branch) %F{yellow}as %F{blue}$(__current_git_user)"
# 	fi
# }

# https://github.com/olivierverdier/zsh-git-prompt
source /Users/olivierlacan/Development/oss/zsh-git-prompt/zshrc.sh
# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%(5~|%-1~/.../%3~|%4~) %{$reset_color%}%% "

PROMPT='%{$fg[yellow]%}%1d%{$reset_color%} %{$fg[green]%}$(git_super_status) $ %{$reset_color%}'

# asdf
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# Go 
export GOROOT=$(brew --prefix go)
export GOBIN=$(go env GOPATH)/bin
pathafter $(go env GOPATH)
pathafter $(go env GOPATH)/bin

# # phpenv (VERY VERY doesn't compile on macOS anymore)
# pathbefore "$HOME/.phpenv/bin"
# eval "$(phpenv init -)"

# Complete profiling (see top of file)
# zprof