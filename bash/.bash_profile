# sbin path for Homebrew
export PATH="/usr/local/sbin:$PATH"

# rbenv binaries
export PATH="$HOME/.rbenv/bin:$PATH"

# nvm
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Yarn
export PATH="$PATH:$HOME/.yarn/bin"

# rbenv
eval "$(rbenv init -)"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Homebrew-installed OpenSSL
export PATH="$(brew --prefix openssl)/bin:$PATH"
# http://engineering.appfolio.com/appfolio-engineering/2016/6/17/configuring-ruby-on-macos-with-openssl
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig:/usr/local/lib/pkgconfig

# enable autojump (j dirname | jumpstats)
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# alias git to hub
eval "$(hub alias -s)"

# load variables I don't want everybody to see when they look at my bash_profile
if [ -f ~/.bash_variables ]; then
  . ~/.bash_variables
fi

# load aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# load colors
if [ -f ~/.bash_colors ]; then
  . ~/.bash_colors
fi

# pretty colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Git Autocompletion
. /usr/local/etc/bash_completion.d/git-completion.bash
. /usr/local/etc/bash_completion.d/hub.bash_completion.sh

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
__rbenv_ps1 (){
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  printf $rbenv_ruby_version
}

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
__current_git_branch (){
  ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
  printf "${ref#refs/heads/}"
}

__current_git_user (){
  git config --get user.name | sed -e "s/\//\&/g"
}

__current_path (){
  echo $(basename "`pwd`")
}

# http://en.wikipedia.org/wiki/Tput#Usage for color codes
__branch_if_repo (){
if [ 'which git' ] && [ -f `which rbenv` ] && [ -d ./.git ]; then
  printf "$(tput setaf 3) on $(tput setaf 2)$(__current_git_branch) $(tput setaf 3)as $(tput setaf 4)$(__current_git_user)"
fi
}

# prompt with git && rbenv
NORMAL="\[\033[0m\]"
export PS1='in \[$(tput setaf 6)\]$(__current_path)$(__branch_if_repo) \n\[$(tput setaf 3)\]\[\033[0;00m\]\$ '

# Default editor
export EDITOR="sublime -w -n"

# Eternal bash history
# from: http://stackoverflow.com/a/19533853/385622
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PATH="$(brew --prefix qt@5.5)/bin:$PATH"
