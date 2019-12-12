# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#caixiong 2018/12/10 the flowing is copyed from ubuntu16.04

#caixiong 2018/05/10 modify PS1
export PS1='\u:\w \$ > '


#caixiong 2018/10/14 modify PS1
#'\[\033[1;31;1m\]\u:\[\033[1;32;1m\]\w\[\033[1;33;1m\]\$\[\033[1;37;1m\]'
#PS1='\[\033[1;32;1m\]\u:\w \$ > '

#copy end!

# caixiong 2018/12/22
alias rm="trash"

# caixiong 2019/02/16
# 不能加引号,否则就是字符串而不是路径了, 此句有错,其实是可以加引号的,
# 只是不能在引号里用~代表home,也就是说引号和~不能同时使用
# 必须用export关键字,否则该变量只有在shell中有值,而在python的os模块中没有该变量
# export PYTHONPATH=~/python:~/tf     
# ps:给程序添加环境变量有两种方式,一个是用export name=value,另一个是在命令前写,如PYTHONPATH=~/python
                    
# caixiong 2019/03/05
#workrave & # 每次打开一个shell窗口,都会执行,而workrave重复执行又会弹出错误框

# caixiong 2019/03/10 命令行开启代理
# git config --global http.proxy 'socks5://127.0.0.1:1080'
# git config --global https.proxy 'socks5://127.0.0.1:1080'

# alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
# alias unsetproxy="unset ALL_PROXY"
#alias ip="curl -i http://ip.cn"

# caixiong 2019/04/30
export PATH=$PATH:~/.local/bin:~/.bin

# caixiong 2019/05/09 设置cuda路径
export PATH=$PATH:/usr/local/cuda-10.0/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-10.0/lib64

# caixiong 2019/07/28 配置MAGMA
export CUDADIR=/usr/local/cuda
source /opt/intel/bin/compilervars.sh intel64

# caixiong 2019/09/30 设置vim alias, 以server方式启动
alias vim="vim --servername VIM"

#echo "basrc have been loaded..."    # shell加载时,此配置文件会以shell脚本形式执行
