
[[ -s "/Users/miseyu/.gvm/scripts/gvm" ]] && source "/Users/miseyu/.gvm/scripts/gvm"
gvm use go1.9.2
if [ -x "`which go`" ]; then
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$PATH
fi

alias tmux='sh ~/tmux.sh'
sh tmux.sh


