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

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# load aliases
if [ -f ~/.aliases.zsh ]; then
  . ~/.aliases.zsh
fi

# autoload completions
autoload -Uz compinit && compinit

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

PROMPT="%{$fg[red]%}%1d%{$reset_color%} %{$fg[blue]%}$(git_super_status) %# %{$reset_color%}"

