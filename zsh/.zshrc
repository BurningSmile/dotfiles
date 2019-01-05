# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Disable nomatch globbing expression
setopt +o nomatch

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi
 
# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Ssh key path
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set terminal type to xterm when in ssh session
if [[ -n $SSH_CONNECTION ]]; then
    export TERM=xterm
else
    case $TERM in (xterm|rxvt-unicode|tmux) export TERM="$TERM-256color";; esac 
fi

# Start tmux on terminal start.
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -2
#fi

# Start powerline on a Debian/Ubuntu system, if it fails check if it is an Arch system.
if [[ -r /usr/share/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/share/powerline/bindings/zsh/powerline.zsh
else
if [[ -r /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi
fi

# Turn off beeping
setopt NO_BEEP

# Start ssh agent if not already started
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent > ~/.ssh-agent-thing
#fi
#if [[ "$SSH_AGENT_PID" == "" ]]; then
#    eval "$(<~/.ssh-agent-thing)"
#fi 

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias git-checkout-all='git reset && git checkout -- .'
alias ls='ls --color=auto'
alias tmuxkill='tmux kill-session -t'
alias scrot-fullscreen='scrot ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias scrot-selection='scrot -s ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias youtube-dlmp3="youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3"
alias gmpv="gnome-mpv"
alias tar-multithreaded='tar -I pigz'
alias rm='rm -I'
alias virsh='sudo virsh'

# Show ping timeouts
alias ping='ping -O'

# Make grep case insentive.
alias grep='grep -i'

# Change prefix key for local tmux when using tmux in a ssh session.
ssh-tmux() {
tmux source-file ~/.tmux-ssh.conf 
/usr/bin/ssh $1 
tmux source-file ~/.tmux.conf
}

# Update pacman mirrors.
updatepacmanmirrors() {
	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
	sudo reflector --country US -p http --save /etc/pacman.d/mirrorlist
	sudo pacman -Syu
}

# Optimize pacman
optimizepacman() {
	sudo pacman -Sc
	sudo pacman-optimize
}

# Mpd Start and refresh the music database.
music() {
	mpd
	mpc update
	ncmpcpp
}

# Update Debian based distros alias
updatedebiansystem() {
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoremove
	sudo apt-get autoclean
}

# Run ls after cd'ing into a directory.
cd () 
{ 
    builtin cd "$*";
    if [ $? -ne 0 ]; then
        if [ ! -x "$1" ] && [ -d "$1" ]; then
            echo -n "Cannot access dir, become root? ";
            read foo;
            if [[ $foo = "y" ]] || [[ $foo = "Y" ]]; then
                sudo bash;
                return;
            else
                builtin cd "$*";
                return;
            fi;
        fi;
    else
        ls --color=auto;
    fi
}

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}


# From: https://old.reddit.com/r/linuxadmin/comments/9m6dkp/what_are_some_aliases_that_really_help_you_out/e7ctary/

## Cleanup git repo after merge.
function gitc {
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$branch" == "master" ]];then
        echo "You're on the master branch.  Let's not kill it please?"
        #exit 1
    else
        git checkout master && git pull && git branch -d $branch && git fetch -p
    fi
}

## Cleanup orphaned, running vagrant boxen.
function kill-vagrants {
    for box in $(vagrant global-status | grep default | awk '{print $1}');do
        vagrant destroy -f $box
    done
}

## Make manpages a bit easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LANG=en_US.UTF-8
export LC_MESSAGES="C"

#dirsize - finds directory sizes and lists them for the current directory
dirsize () {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
  egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm -rf /tmp/list
}

# Alias vi to vim.
alias vi='vim'

# Include ruby in $PATH
PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin:$HOME/.local/bin"
export path

#FZF
#export FZF_DEFAULT_OPTS='--height 40% --border'
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Enable reverse seatch
bindkey -v
bindkey '^R' history-incremental-search-backward
