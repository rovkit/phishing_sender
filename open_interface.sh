#!/bin/bash

echo "starting tmux interface setup"
tmux split-window -h;
tmux send 'docker exec -it eesender /bin/bash' ENTER;
tmux split-window -v;
tmux send 'cd ../../mailtest';
tmux split-window -v;
tmux send 'docker logs --follow eesender >> mail_logs' ENTER;
tmux new-window "/root/phishing_sender/gophish/gophish" ;
tmux split-window -v;