#!/bin/bash
# usage: sh install_env.sh /home/work/liweibin02 all

export HOME=$1

install_self(){
    echo "install self"
    PWD_DIR=$(pwd)
    if [ ! -f $HOME/configure ]; then
        cd $HOME && ln -s $PWD_DIR && cd -
    else
        echo "$HOME/configure is already existed!"
    fi
}

install_env(){
    echo "install env"
    if [ ! -f $HOME/env.sh ]; then
        cd $HOME && cp $HOME/configure/shell/bash_config.sh env.sh 
        sed -i "s|^export HOME=.*$|export HOME=$HOME|" env.sh  # replace HOME environment
        cd -
    else
        echo "$HOME/env.sh already existed!"
    fi
}

install_zsh(){
    if [ ! -f $HOME/.zshrc ]; then
        cd $HOME && ln -s $HOME/configure/shell/.zshrc && cd -
    else
        echo "$HOME/.zshrc is already existed!"
    fi

    if [ ! -d $HOME/.oh-my-zsh ]; then
        if [ ! -d $HOME/configure/shell/.oh-my-zsh ]; then
            echo "$HOME/configure/shell/.oh-my-zsh is not existed"
        else
            cd $HOME && ln -s $HOME/configure/shell/.oh-my-zsh && cd -
        fi
    else
        echo "$HOME/.oh-my-zsh is already existed!"
    fi
}

install_vimrc(){
    echo "install vimrc"
    if [ ! -f $HOME/.vimrc ]; then
        cd $HOME && ln -s $HOME/configure/vim/.vimrc && cd -
    else
        echo "$HOME/.vimrc is already existed!"
    fi
    if [ ! -d $HOME/.vim ]; then
        if [ ! -d $HOME/configure/vim/.vim ]; then
            echo "$HOME/configure/vim/.vim is not existed"
        else
            cd $HOME && ln -s $HOME/configure/vim/.vim && cd -
        fi
    else
        echo "$HOME/.vim is already existed!"
    fi
}

install_tmux_conf(){
    echo "install tmux"
    if [ ! -f $HOME/.tmux.conf ]; then
        cd $HOME && ln -s $HOME/configure/tmux/.tmux.conf && cd -
    else
        echo "$HOME/.tmux.conf is already existed!"
    fi
}

install_jumbo(){
    echo "install jumbo"
    if [ ! -d $HOME/.jumbo ]; then
        cd $HOME && ln -s $HOME/configure/.jumbo && cd -
    else
        echo "$HOME/.jumbo is already existed!"
    fi
}
    

if [ "$2" == "all" ];then
    mkdir $HOME/.tmp/backup_env -p
    mv $HOME/env.sh $HOME/.zshrc $HOME/.vim $HOME/.vimrc $HOME/.tmux.conf $HOEM/.oh-my-zsh $HOME/.jumbo $HOME/.tmp/backup_env
    install_self
    install_env
    install_vimrc
    install_tmux_conf
    install_zsh
    install_jumbo
else
    install_$1
fi
