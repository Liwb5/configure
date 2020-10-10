echo "bash_config.sh"
export HOME=/home/work/liweibin02
# PATH=''

# source /etc/bashrc

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ -f $HOME/.bash_profile ]; then
    source $HOME/.bash_profile
fi

#<<<<<<<<<<<<<<<<<<<<<<<<<<< directory display  >>>>>>>>>>>>>>>>>>>>>>>>>>>> #
# export PS1='\[\e[32;1m\][\u@\W]\$\[\e[0m\] '
export PS1='\[\033[01;32m\]\u@\H \[\033[01;34m\]\w \[\e[35m\][\d \A]\n\[\033[01;34m\] $ \[\033[00m\]'

#<<<<<<<<<<<<<<<<<<<<<<<<<<< custom >>>>>>>>>>>>>>>>>>>>>>>>>>>> #
source $HOME/configure/shell/general_config.sh
source $HOME/configure/env/baidu.sh

