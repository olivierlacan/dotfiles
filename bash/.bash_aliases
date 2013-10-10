# Git
alias gc="git commit"
alias gs="git status"
alias gr="git remote"
alias gb="git branch"
alias gpr="git pull --rebase"
alias blastschema="git checkout db/schema.rb"

# Bundler
alias be="bundle exec"

# Git Tower
alias tower="gittower"

# Xcode
alias xcode="open *.xcodeproj"

if [ -f ~/.bash_secret_aliases ]; then
  source ~/.bash_secret_aliases
fi