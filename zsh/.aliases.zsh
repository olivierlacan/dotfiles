# generate extra short git aliases based on git config aliases
# `git l` for log becomes `gl`
for al in $(git config -l | grep '^alias\.' | cut -d'=' -f1 | cut -d'.' -f2)
do
  alias g$al="git $al"
done

# https://gist.github.com/mwhite/6887990
function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

port() {
  sudo lsof -i"TCP:$1" -sTCP:LISTEN -n -P
}

flushdns() {
  echo "Running dscacheutil -flushcache and restarting mDNSResponder..."
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

dns() {
  local cmd="scutil --dns | grep nameserver"
  echo "Printing current DNS server per this command: "
  echo "\t ${cmd}"
  eval ${cmd}
}

rewritehistory() {
  if [[ $# -eq 0 ]]
  then
    echo 'You need to provide an argument to `rewritehistory` so it can be removed from the history.'
    return 1
  else
    read -r -p "About to delete all items from history that match \"$1\". Are you sure? [y/N] " response
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo "Removing \"$1\" from history..."
      # Delete all matched items from the file, and copy it to a temp location.
      grep -v $1 "$HISTFILE" > /tmp/history
      # Overwrite the actual history file with the temp one.
      mv /tmp/history "$HISTFILE"
      # Clear all items in the current sessions history (in memory).
      history -c
      # Reload history
      history -r
    else
      echo "Cancelled."
    fi
  fi
}

gpgs () { echo -n "$1" | gpg --armor --encrypt -r $2 --trust-model always; }


function time_since_last_commit() {
  git log -1 --date=relative --format="%cd"
}

function g() {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    echo "Last commit: $(time_since_last_commit) ago"
    git status --short --branch
  fi
}

function reload() {
  echo "Reloading ~/.zshrc ..."
  . ~/.zshrc
}

function update(){
  git fetch origin
  git rebase origin/master

  if [ -e yarn.lock ]
  then
      echo "Yarn detected..."
      yarn install
  fi
}

function dockup () {
  if [ -z "$1" ]
  then
    docker-compose up -d
    docker-compose ps
  else
    echo "Running docker-compose up -d on $1";
    docker-compose -f $1 up -d
    docker-compose -f $1 ps
  fi
}

function dockdown () {
  if [ -z "$1" ]
  then
    docker-compose down
  else
    echo "Running docker-compose down on $1";
    docker-compose -f $1 down
  fi
}

function path {
  echo $PATH | tr ':' '\n'
}

function pathprepend {
  case ":$PATH:" in
    *":$1:"*) :;; # path entry is a duplicate
    *) PATH="$1:$PATH";; # prepending to path
  esac
}

function pathappend {
  case ":$PATH:" in
    *":$1:"*) :;; # path entry is a duplicate
    *) PATH="$PATH:$1";; # appending to path
  esac
}