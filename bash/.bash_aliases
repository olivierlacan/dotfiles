#!/usr/bin/env bash
# Aliases

# https://gist.github.com/mwhite/6887990
function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

# generate extra short git aliases based on git config aliases
# `git l` for log becomes `gl`
for al in `git config -l | grep '^alias\.' | cut -d'=' -f1 | cut -d'.' -f2`; do
  alias g$al="git $al"

  complete_func=_git_$(__git_aliased_command $al)
  function_exists $complete_fnc && __git_complete g$al $complete_func
done

# Create a map of aliases so they can be all created in one fell swoop and set
# to autocomplete.
declare -A \
aliases=(
  ["list"]="ls -l"
  ["devlog"]="tail -f log/development.log"
  ["testlog"]="tail -f log/development.log"
  ["be"]="bundle exec"
  ["tower"]="gittower"
  ["xcode"]="open *.xcodeproj"
  ["s"]="sublime"
  ["smod"]="sublime `git diff --name-only HEAD`"
  ["a"]="atom"
  ["vs"]="code"
  ["migrateback"]="rake -g rollback_branch_migrations[master]"
  ["killpg"]="rm /usr/local/var/postgres/postmaster.pid"
  ["dup"]="docker-compose up -d"
)

for element in "${!aliases[@]}"
do
  value=${aliases[$element]}
  # create alias from element to value
  alias ${element}="${value}"
  # add autocompletion to alias command name
  # complete -c ${element}
done

if [ -f ~/.bash_secret_aliases ]; then
  source ~/.bash_secret_aliases
fi

# Hub
eval "$(hub alias -s)"

# Force Postgres to release its process ID
alias killpg='rm /usr/local/var/postgres/postmaster.pid'

# Jump to blog
alias blog='j olivierlacan.com'

port() {
  sudo lsof -i"TCP:$1" -sTCP:LISTEN -n -P
}

flushdns() {
  echo "Running dscacheutil -flushcache and restarting mDNSResponder..."
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

gpgs () { echo -n "$1" | gpg --armor --encrypt -r $2 --trust-model always; }

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
