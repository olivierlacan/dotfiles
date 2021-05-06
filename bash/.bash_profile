# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Load path alterations
if [ -f ~/.path_alterations ]; then
  . ~/.path_alterations
fi

# Bash completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# brew bash-completion
if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
  . $(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh

  # Add git completion to aliases
  __git_complete gco _git_checkout
  __git_complete gm __git_merge
  __git_complete gp _git_pull
  __git_complete gpu _git_push
fi

_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh

# in a specified folder ($1) find all the files matching a file pattern
# and sort them by line count
sortlong()
{
  find "$1" -type f -name "$2" -exec wc -l {} + | sort -rn
}

# enable autojump (j dirname | jumpstats)
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# prompt with ruby version
# rbenv version | sed -e 's/ .*//'
__rbenv_ps1 (){
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
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
if [ -f `which git` ] && [ -f `which rbenv` ] && [ -d ./.git ]; then
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

# load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Homebrew is a pain in the ass with the constant forced updates
export HOMEBREW_AUTO_UPDATE_SECS=600000

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

echo_and_execute() {
  echo "\$ $@" ; "$@" ;
}

pglogs (){
  echo_and_execute tail -f /usr/local/var/log/postgres.log
}
