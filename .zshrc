# The following lines were added by compinstall
 
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '~/.zshrc'
 
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# colors
autoload colors zsh/terminfo
colors
# set some colors
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";



autoload -Uz vcs_info
FMT_BRANCH="${PR_GREEN}%b%u%c${PR_RESET}" # e.g. master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"   # e.g. (rebase-i)
FMT_PATH="%R${PR_YELLOW}/%S"              # e.g. ~/repo/subdir

# check-for-changes can be really slow.
# # you should disable it, if you work with large repositories
zstyle ':vcs_info:*'              enable            git svn bzr
zstyle ':vcs_info:*'              check-for-changes true
zstyle ':vcs_info:*'              get-revision      true
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"

 
# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
#bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
 
bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
 
#setopt prompt_subst
#PROMPT="%{$terminfo[bold]$fg[green]%}[%(?..%{$fg[red]%}%?%{$fg[green]%}|)%{$fg[blue]%}%"'$((30 - ${(e)exit_code})'")<..<%/%{$fg[green]%}]$%{$terminfo[sgr0]%} "

if [[ "`id -u`" == "0" ]]; then
    PROMPT="%{$terminfo[bold]$fg[red]%}%n%{$terminfo[sgr0]%}@%{$fg[yellow]%}%m%{$fg[default]%}:%{$fg[cyan]%}%~%{$fg[default]%}$ "
else
    PROMPT="%{$terminfo[bold]$fg[yellow]%}%n%{$terminfo[sgr0]%}@%{$fg[yellow]%}%m%{$fg[default]%}:%{$fg[cyan]%}%~%{$fg[default]%}$ "
fi

##### PROMPT STUFF #####
#autoload -U promptinit
#promptinit
#prompt adam2


#RPROMPT="%(?..%{$terminfo[bold]$fg[green]%}[%{$fg[red]%}%?%{$fg[green]%}]%{$terminfo[sgr0]%})"
RPROMPT=""

function chpwd {
case $TERM in
*xterm*|*rxvt*|ansi) print -Pn "\e]2;%/ | %y\a" # better for remote shells: "\e]2;%n@%m: %~\a"
;;
screen) print -Pn "\e_ %/ | %y\e\\" # better for remote shells: "\e_ %n@%m: %~\e\\"
;;
esac
}
 
# Before prompt
function precmd {
 
case $TERM in
*xterm*|*rxvt*|ansi) print -Pn "\e]2;%/ | %y\a" # better for remote shells: "\e]2;%n@%m: %~\a"
;;
screen) print -Pn "\e_ %/ | %y\e\\" # better for remote shells: "\e_ %n@%m: %~\e\\"
;;
esac
}
 
# After enter but before command
function preexec {
case $TERM in
*xterm*|*rxvt*|ansi) print -nPR $'\e]0;'"$1 | %y"$'\a' # better for remote shells: "\e]2;%n@%m: $1\a"
;;
screen) print -nPR $'\e_ '"$1 | %y"$'\e\\' # better for remote shells: "\e_ %n@%m: $1\e\\"
;;
esac
}
 
export EDITOR='vim'
export BROWSER='chromium-browser'

# Ports-Specific:
alias p='psearch'
alias m='sudo time make config-recursive install clean'
alias mm='sudo time make config-recursive install clean; beep; sleep .07; beep -p 600'
#alias pd="cd /usr/ports$1"
alias pfu='sudo portsnap fetch update'
alias pb='sudo portmaster -Bad'

function pd() { cd /usr/ports/${1} }

# Little stupid things to make life .. nice :)
alias vi='vim'
alias lksc='xscreensaver-command -lock'

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias j=jobs
if ls -F --color=auto >&/dev/null; then
  alias ls="ls --color=auto -F"
else
 alias ls="ls -F"
fi
alias grep="egrep --color=auto"
alias diff="colordiff"
alias ll="ls -l"
alias l="ls -l"
alias la="ls -la"
alias lh="ls -lh"
alias l.='ls -d .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias p='pwd'
alias cd..='cd ..'
alias ..='cd ..'
alias i='ipython'
# alias tsl="tail -f /var/log/syslog"
alias df="df -hT"
alias efte="efte -Ttags"


# BSD, but not *ports* specific.
alias docup='sudo cvsup -L 2 /etc/supfile'

# X11
alias comp='compiz --replace --sm-disable --ignore-desktop-hints ccp &'

# Git
alias ga='git add'
alias gp='git push'

# Python
alias pyc='rm *.pyc; rm */*.pyc'


stty -ixon -ixoff
 
export GREP_COLOR="1;33"
export PATH="/usr/sbin:/usr/local/sbin:$PATH"
[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin

export PYTHONSTARTUP=~/.pythonrc 
export PAGER=most

# GoLang Specific:
function go() {
   NAME=`echo ${1} | cut -d '.' -f 1`
   6g ${1};
   6l -o $NAME $NAME.6;
   rm $NAME.6;
#   echo "'$NAME'"
}

# Go stuff.

ARCH_GO_ENV="/etc/profile.d/go.sh"
if [ -f $ARCH_GO_ENV ]; then
    source $ARCH_GO_ENV
else
    export GOROOT=$HOME/go
    if [[ "`uname -m`" == "x86_64" ]]; then
        export GOARCH=amd64
    else
        export GOARCH=386
    fi
    export GOOS=linux
    export GOBIN=$GOROOT/bin
    export PATH="$PATH:$GOBIN"
fi


function precmd {
    vcs_info 'prompt'
    if [[ $vcs_info_msg_0_ != "no" ]]; then
       RPROMPT="${vcs_info_msg_0_}"
    fi
}

# rvm stuff
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# local stuff
[[ -s "$HOME/.localsh" ]] && source "$HOME/.localsh"
