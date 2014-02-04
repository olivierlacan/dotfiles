# make sure local binaries are fired first, yes, I know this is super 
# fucking unsafe, but if someone can exploit this, I have other issues.
# then look for the Heroku binary
# then look into rbenv shims
# then look into Homebrew binaries
# then delegate to the system $PATH
export PATH="bin:/Users/olivierlacan/.rbenv/bin:/Users/olivierlacan/.rbenv/shims:/usr/local/heroku/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PATH="$PATH:$NODE_PATH"

# enable shims and autocompletion for rbenv
# disabled because it prepends /Users/olivierlacan/.rbenv/shims
# and I need ./bin to be first for implicit Bundler-powered gemsets
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# enable autojump (j dirname | jumpstats)
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# load variables I don't want everybody to see when they look at my bash_profile
if [ -f ~/.bash_variables ]; then
  source ~/.bash_variables
fi

# load aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# load colors
if [ -f ~/.bash_colors ]; then
  source ~/.bash_colors
fi

# pretty colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Git Autocompletion
source /usr/local/etc/bash_completion.d/git-completion.bash 
source /usr/local/etc/bash_completion.d/hub.bash_completion.sh

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
  echo $(basename `pwd`)
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

# Chad Miller made me do this, it's pretty cool
# Displays the current user@hostname and PWD in the terminal title (or tab)
# TODO: output the currently running script before this
# PROMPT_COMMAND='echo -ne "\033]0;$(__current_path)\007"'

# SCM breeze
[ -s "/Users/olivierlacan/.scm_breeze/scm_breeze.sh" ] && source "/Users/olivierlacan/.scm_breeze/scm_breeze.sh"

# Default editor
export EDITOR="sublime -Wn"
[[ -s /Users/olivierlacan/.nvm/nvm.sh ]] && . /Users/olivierlacan/.nvm/nvm.sh # This loads NVM
