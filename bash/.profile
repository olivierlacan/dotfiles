# Load path alterations
if [ -f ~/.path_alterations ]; then
  . ~/.path_alterations
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
