# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U +X compinit && compinit
autoload -U +X compdef && compdef

if [[ -s "${ZDOTDIR:-$HOME}/.zsh_functions" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh_functions"
fi

setopt nonomatch

export GO111MODULE=on
export GOPATH=$HOME/git
export PATH=$GOPATH/bin:$PATH
export GOPROXY=direct
export GOSUMDB=off

function git(){hub "$@"}

. $(brew --prefix asdf)/libexec/asdf.sh

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include"
export PATH="${HOME}/bin:$PATH"

export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

source $HOME/.cargo/env
