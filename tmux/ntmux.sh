#!/bin/sh 
if [ $# != 2 ]; then
    echo "must specified tmux session name and window number"
    exit 1
fi
source ~/env.sh

tmux new-session -s "$1" -d
# tmux send-keys "source ~/env.sh" Enter
tmux send-keys "zsh" Enter
tmux send-keys "cd" Enter

# tmux split-window -h
# tmux split-window -v
for i in `seq 2 $2`; do
    tmux new-window
    tmux send-keys "zsh" Enter
    tmux send-keys "cd" Enter
done
tmux -2 attach-session -d
