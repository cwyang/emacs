# .bashrc from citadel

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

if [ "$PS1" ]; then
    case $TERM in
    xterm*|vte*|screen*)
      PROMPT_COMMAND='printf "\033k%s:%s\033\\" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
      ;;
    *)
      ;;
    esac
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
fi

# User specific aliases and functions
export CVSROOT=:pserver:cwyang@cvs.aratech.co.kr:/var/lib/cvs
export PATH=/home/cwyang/emacs24/bin/:$PATH
export MANPATH=/home/cwyang/localman:$MANPATH
alias gitlog='git log --graph --format='\''%C(11)%h%Creset %s (%an)'\'''
[ -z "$TMUX" ] && export TERM=xterm-256color
export TMOUT=10000000000
