# https://gist.github.com/mwhite/6887990
function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

# generate extra short git aliases based on git config aliases
# `git l` for log becomes `gl`
for al in `git config -l | grep '^alias\.' | cut -d'=' -f1 | cut -d'.' -f2`; do
  alias g$al="git $al"

  # for some reason the lc alias leads to a git ERROR: could not find function '_git_rev-list'
  # so we're not bothering with autocomplete on it
  if [[ "$al" = "lc" ]]; then
    continue
  fi
  complete_func=_git_$(__git_zsh_cmd_alias $al)
  function_exists $complete_fnc && __git_complete g$al $complete_func
done