if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U +X compinit && compinit
autoload -U +X compdef && compdef

if [[ -s "${ZDOTDIR:-$HOME}/.zsh_functions" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh_functions"
fi

setopt nonomatch

export PATH=/opt/homebrew/bin:$PATH
export GO111MODULE=on
export GOPATH=$HOME/git
export PATH=$GOPATH/bin:$PATH
export GOPROXY=direct
export GOSUMDB=off
export GPG_TTY=$(tty)

. ~/.asdf/plugins/java/set-java-home.bash

function git(){hub "$@"}

if [ -x "`which direnv`" ]; then
  eval "$(direnv hook zsh)"
fi

. $(brew --prefix asdf)/libexec/asdf.sh

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source /Users/miseyu/.docker/init-zsh.sh || true # Added by Docker Desktop


export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PATH="$(brew --prefix bison)/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export PKG_CONFIG_PATH=$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix krb5)/lib/pkgconfig:$(brew --prefix libedit)/lib/pkgconfig:$(brew --prefix libxml2)/lib/pkgconfig:$(brew --prefix openssl)/lib/pkgconfig
