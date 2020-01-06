# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-src () {
  local selected_dir=$(ghq list --vcs git -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=$PYENV_ROOT/bin:$PATH

eval "$(rbenv init -)"

eval "$(nodenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/miseyu/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/miseyu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/miseyu/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/miseyu/google-cloud-sdk/completion.zsh.inc'; fi

setopt nonomatch

source $HOME/.gvm/scripts/gvm
gvm use go1.13
if [ -x "`which go`" ]; then
    export GOPATH=$HOME/git
    export PATH=$GOPATH/bin:$PATH
fi
eval "$(direnv hook zsh)"

export GO111MODULE=on
export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
export PATH="$HOME/bin:$PATH"

function git(){hub "$@"}
