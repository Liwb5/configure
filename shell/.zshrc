# If you come from bash you might have to change your $PATH.

echo '.zshrc'

export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="liwb_ys"
# ZSH_THEME="liwb_robbyrussell"
# ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# for autojump 
# [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

plugins=(git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    # autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration
#<<<<<<<<<<<<<<<<<<< autosuggestions config >>>>>>>>>>>>>>>>>>>>>>>>>>>> #
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
# AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=250'


#<<<<<<<<<<<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>>>>>>>> #
# fix the error of complete not found
autoload bashcompinit
bashcompinit

# Uncomment the following line to disable auto-setting terminal title.
# for example, prevent zsh to change the window name of Tmux
DISABLE_AUTO_TITLE="true"

# not share command history in different windows/panes
setopt noincappendhistory
setopt nosharehistory
# 即刻把命令行命令写到zsh_history文件
setopt INC_APPEND_HISTORY


# 关闭zsh通配符自动匹配
setopt nonomatch

# source /etc/bashrc

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ -f $HOME/.bash_profile ]; then
    source $HOME/.bash_profile
fi

source $HOME/configure/shell/general_config.sh
source $HOME/configure/env/baidu.sh

# for tmux: 非当前窗口的程序完成之后，高亮对应的tmux的title 窗口
precmd () {
  echo -n -e "\a"
} 

if [[ ! -z $TMUX ]]; then 
    printf '\n'; 
fi

# Path to your oh-my-zsh installation.
