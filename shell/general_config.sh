echo "general_config.sh"
#<<<<<<<<<<<<<<<<<<<<<< export >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#

#------------- ls command: display diferent color in different files --------------------#
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"


#------------- trash config --------------------#
alias mv='mv -i' # query before recover files with samename
trash_dir="$HOME/projects/.trash"
alias rl="ls -ahlt $trash_dir"
if [ ! -d  $trash_dir ]; then
    mkdir -p $trash_dir
fi

trash(){
    for i in $*; do
        name=`basename $i`
        abs_path=`readlink -f $i | sed 's/\//_/g'`
        new_name="$trash_dir/${name}${abs_path}_$(date "+%y_%m_%d_%T")"
        mv $i $new_name && echo "$i deleted, you can find it in $new_name"
    done
}

#------------- enviroment config --------------------#
# 使用vim作为任何程序的标准编辑器
export VISUAL=vim
export EDITOR="$VISUAL"

#------------- language config --------------------#
# export LANG="en_US.utf8"
# export LC_ALL="en_US.utf8"
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

#------------- tmux config --------------------#
# export TERM=screen
export TERM=xterm-256color
export TERMINFO=/usr/share/terminfo
export TMOUT=0
if [ ! -d $HOME/.tmp ]; then
    mkdir $HOME/.tmp 
fi
export TMPDIR=$HOME/.tmp
export TMUX_TMPDIR=$HOME/.tmp # The tmp directory of tmux2 is TMUX_TMPDIR 
alias tmux='tmux -2'
alias t="tmux at -t"

#-------------for jumping to directory faster --------------------#
export MARKPATH=$HOME/configure/.marks

function jump {
cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
# mkdir -p "$MARKPATH"; ln -s "${PWD/#$HOME/'~'}" "$MARKPATH/$1"
}
function unmark {
rm -i "$MARKPATH/$1"
}
function marks {
# 在linux下需要使用第一行，在mac下可能使用第二行. 区别是\t
ls -lt "$MARKPATH" | awk '{if(NF > 4){printf("%s\t%s  %s\n",$(NF-2),$(NF-1),$NF)}}'
# ls -l "$MARKPATH" | sed 's/ / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
# ls -l "$MARKPATH" | sed 's/ / /g' | cut -d' ' -f9- | sed 's/ -/ -/g' && echo
}
_completemarks() {
local curw=${COMP_WORDS[COMP_CWORD]}
local wordlist=$(find $MARKPATH -type l -printf "%f\n")
COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
return 0
}

complete -F _completemarks jump unmark
###################################################################




###################################################################
#<<<<<<<<<<<<<<<<<<<<<< alias >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
alias ls='ls --color=tty'
alias lh='ls -lh'
alias lt='ls -lt'
alias ll='ls -alh --color=tty'
alias li='ll -I "*.pyc"'


# git 
alias gs='git status'
alias gl='git log --all --graph --decorate'
alias gd='git diff'


# others
alias vi='vim'
alias duh='du -h --max-depth=1'
alias tf='tail -f'
alias ns='nvidia-smi'

alias igu='piconv -f gbk -t utf8'
alias iug='piconv -f utf8 -t gbk'

alias ginfo='watch -n 1 nvidia-smi'

###################################################################
#<<<<<<<<<<<<<<<<<<<<<< function >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#
# source func.sh
function check(){
    code=$?
    mark=""
    if [ $# == 1 ]; then
        mark=$1
    fi
    if [ ! ${code} -eq 0 ]; then
        echo "Exit Code ${code}. ${mark}"
    fi
    return ${code}
}

function check_and_exit(){
    check
    exit $?
}

function getgpu(){
    if ! command -v gpustat > /dev/null 2>&1; then
        echo "Error: gpustat not install."
        return 0
    fi

    # all_idle_gpus=$(gpustat | grep "0 /" | sed -r "s/.*\[([0-9]+)\].*/\1/" | awk 'BEGIN{gpus=""}{if(NR==1){gpus=$1}else{gpus=(gpus","$1)}}END{print gpus}')

    all_idle_gpus=$(gpustat | grep -v baidu |awk -F' ' '{if($9 < 1000){print $1,$9}}' |sed -r "s/.*\[([0-9]+)\].*/\1/" | awk 'BEGIN{gpus=""}{if(NR==1){gpus=$1}else{gpus=(gpus","$1)}}END{print gpus}')

    gpus_num=$(echo ${all_idle_gpus} | awk -F',' '{print NF}')
    if [ $gpus_num -eq 0 ]; then
        echo "No GPU is available"
        echo "export CUDA_VISIBLE_DEVICES="
        return 0
    fi

    # set how many GPUs want to use
    num_gpu_to_use=1
    if [ $# -ge 1 ]; then
        num_gpu_to_use=$1
        # if $1 == 0, use all available GPUs
        if [ ${num_gpu_to_use} -eq 0 ]; then
            num_gpu_to_use=$gpus_num
        fi

        if [ ${num_gpu_to_use} -gt ${gpus_num} ]; then
            echo "The number of GPUs you can accept must be [1, ${gpus_num}, and your input is ${num_gpu_to_use}]"
            return 0
        fi
    fi

    resule=""
    cc=0
    arr=(`echo ${all_idle_gpus} | tr ',' ' '`) # string to array
    for gpu in ${arr[@]}; do
        if [ ${num_gpu_to_use} -eq 1 ]; then
            result="${gpu}"
        else
            result="${result},${gpu}"
        fi
        # if get enough GPUs, then break
        cc=$(($cc+1))
        if [ ${cc} -eq ${num_gpu_to_use} ]; then
            break
        fi
    done

    export CUDA_VISIBLE_DEVICES=$result

    echo "The below GPUs are available to use: ${all_idle_gpus}"
    echo "export CUDA_VISIBLE_DEVICES=${result}"
}

myshare () {
    for name in $*
    do
        echo ${USER}@${HOSTNAME}:`pwd`/$name
    done
}



start_server () {
    echo "http://"`hostname`:8034
    # python -m SimpleHTTPServer 8034
    python -m http.server 8034
}

# 在符合条件的文件中，查找含有指定字符串的行。
search () {
    if [ $# -eq 3 ]; then
        find . -maxdepth $3 -name "*.$1" | xargs grep -n "$2" | grep "$2"
    elif [ $# -eq 2 ]; then
        find . -name "*.$1"|xargs grep -n "$2" | grep "$2"
    else
        grep -rn "$1" *
    fi
    # search filename match
    # find ./ -name '*sqlite*'
}

set_cuda(){
    export CUDA_VISIBLE_DEVICES=$1
}

see_cuda(){
    echo $CUDA_VISIBLE_DEVICES
}

line(){
    if [ $# -gt 0 ]
        then
            awk -F"\t" '{print "=== LINE: "FNR" =================================="; for(i=1;i<=NF;i++){print i"\t"$i}}' $@ | less -r
        else
            awk -F"\t" '{print "=== LINE: "FNR" =================================="; for(i=1;i<=NF;i++){print i"\t"$i}}' - | less -r
    fi
}

function scan() {
    if [ $# -eq 1 ]; then
        head -n 10 $1 | vim -
    else
        head -n $2 $1 | vim -
    fi
}

mf(){
    filter="grep $1"
    for name in $*
    do
        if [ $name = "kill" ]
        then
            break
        fi
        filter="$filter | grep $name"
    done
    filter="$filter | grep -v grep"

    if [ $name = "kill" ]  
    then
        # echo "kill"
        ps -ef | eval $filter | awk '{print $2}' | xargs -I {} kill -9 {}
    else
        ps -ef | eval $filter
    fi
}

mc(){
    filter="grep $1"

    for name in $*
    do
        filter="$filter | grep $name"
    done
    eval $filter
}

his() {
    history -a | mc $@ | vim -
}


clean_gpu(){
    lsof /dev/nvidia$1  | awk  '{print $2}' | xargs -I {} kill -9 {}
}

ram() {
    # usage: ram 12333(进程号) 5(时间间隔)
    pid=$1 #获取进程pid
    echo "monitor PID: $pid"

    interval=$2 #设置采集间隔

    status_file=/proc/$pid/status

    while true
    do
        if [ ! -f $status_file ]; then
            echo "PID: $pid is not existed; break"
            break
        fi
        ram=`cat $status_file | grep -e VmRSS`  #获取内存占用
        mem_percent=`top -n 1 -p $pid | tail -2 | head -1 | awk '{ssd=NF-3} {print $ssd}'`
        echo "$(date +"%y-%m-%d %H:%M:%S"): $ram | MemoryPercent: $mem_percent%"
        sleep $interval

        memory=`echo $ram | awk '{print $2}'`
        # if memory larger than 200G, kill the process
        if [ $memory -gt 200000000 ]; then
            kill -9 $pid
        fi
    done
}

sshagent() {
    eval "$(ssh-agent -s)"
    ssh-add /home/work/.ssh/id_rsa.liweibin02
}


