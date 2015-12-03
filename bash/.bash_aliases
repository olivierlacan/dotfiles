# Git
alias gc="git commit"
alias gs="git status"
alias gr="git remote"
alias gb="git branch"
alias gm="git merge"
alias gp="git pull"
alias gpu="git push"
alias gpr="git pull --rebase"
alias gco="git checkout"
alias blastschema="git checkout db/schema.rb"
alias gitpurge="git checkout master && git remote update --prune | git branch -r --merged | grep -v master | sed -e 's/origin\//:/' | xargs git push origin"
alias gittags="for t in `git tag -l`; do git cat-file -p `git rev-parse $t`; done"

# Bundler
alias be="bundle exec"

# Git Tower
alias tower="gittower"

# Xcode
alias xcode="open *.xcodeproj"

# Sublime
alias s="sublime"

# Atom
alias a="atom"

# Rails
alias migrateback='rake -g rollback_branch_migrations[master]'

if [ -f ~/.bash_secret_aliases ]; then
  source ~/.bash_secret_aliases
fi

# brew bash-completion
if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash

  # Add git completion to aliases
  __git_complete gco _git_checkout
  __git_complete gm __git_merge
  __git_complete gp _git_pull
  __git_complete gpu _git_push
fi
