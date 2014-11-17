
if $(tmux has-session); then
  killall -SIGWINCH tmux
  tmux attach
else
  tmux
fi
