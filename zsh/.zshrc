# AutoJump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# rbenv/ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"

# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# Volta/Node
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# git completion
autoload -Uz compinit && compinit

# load aliases
if [ -f ~/.aliases.zsh ]; then
  source ~/.aliases.zsh
fi

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

# # prompt with git && rbenv
# export PS1="in %F{cyan} $(__current_path) $__branch_if_repo %F{yellow} %F{reset} $ "
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

# Zscaler
export NODE_EXTRA_CA_CERTS=/Users/olivier-lacan/zscaler/ZscalerRootCertificate-2048-SHA256.crt

# Custom Git ZSH prompt
autoload -U colors && colors

source /Users/olivier-lacan/Development/oss/zsh-git-prompt/zshrc.sh
# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%(5~|%-1~/.../%3~|%4~) %{$reset_color%}%% "

PROMPT='%{$fg[yellow]%}%1d%{$reset_color%} %{$fg[green]%}$(git_super_status) $ %{$reset_color%}'

# Homebrew-installed Scala
export PATH="/opt/homebrew/opt/scala@2.12/bin:$PATH"

# Homebrew-installed Java
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# Get ZSH to stop assuming a word boundary with special characters in it 
# is a WHOLE word boundary
# via: https://unix.stackexchange.com/a/258661/65663
autoload -U select-word-style
select-word-style bash

# https://apple.stackexchange.com/a/365225/15253
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

