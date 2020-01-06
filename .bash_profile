
[[ -s "/Users/miseyu/.gvm/scripts/gvm" ]] && source "/Users/miseyu/.gvm/scripts/gvm"
if [ -x "`which gvm`" ]; then
    gvm use go1.13
fi
if [ -x "`which go`" ]; then
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$PATH
fi

alias tmux='sh ~/tmux.sh'
sh tmux.sh
