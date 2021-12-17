# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U +X compinit && compinit
autoload -U +X compdef && compdef

# Peco
function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-git-checkout() {
  git branch | peco | xargs git checkout
}
zle -N peco-git-checkout
bindkey '^o' peco-git-checkout

setopt nonomatch
export PATH="$HOME/bin:$PATH"

if [ -x "`which rbenv`" ]; then
  eval "$(rbenv init -)"
fi
if [ -x "`which nodenv`" ]; then
  eval "$(nodenv init -)"
fi
if [ -x "`which direnv`" ]; then
  eval "$(direnv hook zsh)"
fi
if [ -x "`which pyenv`" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
if [ -x "`which jenv`" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
if [ -x "`which gvm`" ]; then
  source $HOME/.gvm/scripts/gvm
  gvm use go1.17
  export GO111MODULE=on
  export GOPATH=$HOME/git
  export PATH=$GOPATH/bin:$PATH
  export GOPROXY=direct
  export GOSUMDB=off
fi

function git(){hub "$@"}

# Google Cloud SDK.
export GX_CONFIG_DIR=$HOME/.gx-config
function gx-init() {
  name="$1" # alias
  if [ -z "$1" ]; then
    echo "gx-init <name> [project]"
    return 1
  fi
  if [ -z "$2" ]; then
    project="$name"
  else
    project="$2"
  fi
  gx-activate "${name}"
  gcloud config configurations create "${name}"
  gcloud config set project "${project}"
  gcloud auth login
}
function gx-activate() {
  name="$1"
  export CLOUDSDK_CONFIG="${GX_CONFIG_DIR}/${name}"
  export GOOGLE_APPLICATION_CREDENTIALS="${CLOUDSDK_CONFIG}/application_default_credentials.json"

}
function gx-current() {
  echo ${CLOUDSDK_CONFIG##*/}
}
function gx-complete() {
  _values "gcloud-config" $(\ls "${GX_CONFIG_DIR}")
}
function gx() {
  name="$1"
  if [ -z "${name}" ]; then
    name=$(\ls "${GX_CONFIG_DIR}" | peco)
  fi
  gx-activate "${name}"
}
compdef gx-complete gx

function gke-get-credentials() {
  cluster="$1"
  zone_or_region="$2"
  if echo "${zone_or_region}" | grep '[^-]*-[^-]*-[^-]*' > /dev/null; then
    echo "gcloud container clusters get-credentials \"${cluster}\" --zone=\"${zone_or_region}\""
    gcloud container clusters get-credentials "${cluster}" --zone="${zone_or_region}"
  else
    echo "gcloud container clusters get-credentials \"${cluster}\" --region=\"${zone_or_region}\""
    gcloud container clusters get-credentials "${cluster}" --region="${zone_or_region}"
  fi
}
function gcloud-current-project() {
  gcloud config get-value project 2>/dev/null
}

export GKX_CONFIG_DIR=$HOME/.gkx-config
function gkx-init() {
  name=$(gx-current)
  gcloud container clusters list | tail -n +2 |  while read line; do
    cluster=$(echo "${line}" | awk '{print $1}')
    zone_or_region=$(echo "${line}" | awk '{print $2}')
    gkx-activate "${name}" "${cluster}"
    gke-get-credentials "${cluster}" "${zone_or_region}"
  done
}
function gkx-activate-default() {
  name=$(gx-current)
  if [ -d "${GKX_CONFIG_DIR}/${name}" ]; then
    cluster=$(\ls "${GKX_CONFIG_DIR}/${name}" | head -n 1)
    export KUBECONFIG="${GKX_CONFIG_DIR}/${name}/${cluster}"
  else
    unset KUBECONFIG
  fi
}
function gkx-activate() {
  name="$1"
  cluster="$2"
  export KUBECONFIG="${GKX_CONFIG_DIR}/${name}/${cluster}"
}
function gkx-current() {
  echo ${KUBECONFIG##*/}
}
function gkx-complete() {
  name=$(gx-current)
  _values "gke-config" $(\ls "${GKX_CONFIG_DIR}/${name}")
}
function gkx() {
  cluster="$1"
  name=$(gx-current)
  if [ -z "${cluster}" ]; then
    cluster=$(\ls "${GKX_CONFIG_DIR}/${name}" | peco)
  fi
  gkx-activate "${name}" "${cluster}"
}
compdef gkx-complete gkx

alias avl='(){ open -na "Google Chrome" --args --incognito --user-data-dir=$HOME/Library/Application\ Support/Google/Chrome/aws-vault/$@ $(aws-vault login $@ --stdout) }'

source $HOME/.zsh_functions

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/miseyu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/miseyu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/miseyu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/miseyu/google-cloud-sdk/completion.zsh.inc'; fi
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

. $(brew --prefix asdf)/asdf.sh


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mysql-client/lib"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include"
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="/usr/local/opt/yq@3/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="${HOME}/bin:$PATH"

export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

source $HOME/.cargo/env
