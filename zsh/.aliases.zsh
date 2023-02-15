# generate extra short git aliases based on git config aliases
# `git l` for log becomes `gl`
for al in $(git config -l | grep '^alias\.' | cut -d'=' -f1 | cut -d'.' -f2)
do
  alias g$al="git $al"
done

# https://gist.github.com/mwhite/6887990
function_exists() {
  declare -f -F "$1" > /dev/null
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
    reference="$1"

    read -r -p "About to delete all items from history that match \"$1\". Are you sure? [y/N] " response
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo "Removing \"$reference\" from history..."
      # Delete all matched items from the file, and copy it to a temp location.
      grep -v $reference "$HISTFILE" > /tmp/history
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

gpgs () { 
  string="$1"
  echo -n "$string" | gpg --armor --encrypt -r "$2" --trust-model always; 
}


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

function dockit(){
  command="$1"
  config="$2"

  if [ -z $config ]
  then
    docker-compose "$command" -d
    docker-compose ps
  else
    echo "Running docker-compose $command -d on $config";
    docker-compose -f "$config" "$command" -d
    docker-compose -f "$config" ps
  fi
}

function dockup () {
  dockit up "$1"
}

function dockdown () {
  dockit down "$1"
}

function path {
  echo "Load path entries:"
  echo $PATH | tr ':' '\n\t'
}

function pathadd {
  # echo "pathadd ($1): $2"
  position="$1"
  entry="$2"

  if [[ -z "$entry" ]]; then
    echo "Attempted to $position empty string" && return;
  fi

  if [[ $PATH =~ "$entry" ]]; then
    echo "Entry $entry is already in the PATH" && return;
  fi

  case "$position" in
    *"before"*)
      PATH="$entry:$PATH"
      ;;
    *"after"*)
      PATH="$PATH:$entry"
      ;;
    *)
      echo "No position match, use either 'before' or 'after' with 'pathadd'"
  esac
}

function pathbefore {
  pathadd before $1
}

function pathafter {
  pathadd after $1
}

function addflag {
  if [ $# -lt 2 ]
  then
    echo "Usage: $addflag[1] <flag-name> <value>"
    return
  fi

  echo "argument 1: $1"
  echo "argument 2: $2"

  echo "${(P)$2}"

  echo "$1"
}


function browse {
  if [ -d .git ]; then
    gh repo view --web
  fi
}

function network {
  sudo arp-scan 192.168.1.0/24
}

alias s="subl"