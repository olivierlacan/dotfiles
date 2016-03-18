# Load $PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh
eval "$(rbenv init -)"

# enable autojump (j dirname | jumpstats)
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# alias git to hub
eval "$(hub alias -s)"

# load variables I don't want everybody to see when they look at my bash_profile
if [ -f ~/.bash_variables ]; then
  source ~/.bash_variables
fi

# load aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
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

# Default editor
export EDITOR="sublime -w -n"
