# Bash
alias list="ls -l"
alias devlog="tail -f log/development.log"
alias testlog="tail -f log/development.log"

# https://gist.github.com/mwhite/6887990
function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
  alias g$al="git $al"

  complete_func=_git_$(__git_aliased_command $al)
  function_exists $complete_fnc && __git_complete g$al $complete_func
done

# Bundler
alias be="bundle exec"

# Git Tower
alias tower="gittower"

# Xcode
alias xcode="open *.xcodeproj"

# sublime
alias s="sublime"
alias smod='sublime `git diff --name-only HEAD`'

# Atom
alias a="atom"

# Rails
alias migrateback='rake -g rollback_branch_migrations[master]'

if [ -f ~/.bash_secret_aliases ]; then
  source ~/.bash_secret_aliases
fi

# Hub
eval "$(hub alias -s)"
