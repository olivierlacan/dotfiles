export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# load aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# AutoJump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
function rbenv_ps1 (){
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
}

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
function current_git_branch (){
  ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
  printf "${ref#refs/heads/}"
}

function current_git_user (){
  git config --get user.name | sed -e "s/\//\&/g"
}

function current_path (){
  echo $(basename "`pwd`")
}

# http://en.wikipedia.org/wiki/Tput#Usage for color codes
function branch_if_repo (){
	autoload colors && colors
	if [ -f `which git` ] && [ -f `which rbenv` ] && [ -d ./.git ]; then
	  printf "%F{yellow} on %F{green}$(__current_git_branch) %F{yellow}as %F{blue}$(__current_git_user)"
	fi
}

# prompt with git && rbenv
export PS1="in %F{cyan} $(__current_path) $__branch_if_repo %F{yellow} %F{reset} $ "
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
