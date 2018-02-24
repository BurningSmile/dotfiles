# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git common-aliases python)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi 

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias git-checkout-all='git reset && git checkout -- .'
alias removeorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias ls='ls --color=auto'
alias rdesktop-localhost-default-port='rdesktop -g 1920x1080 -P -z -x l -r sound:off localhost:3389'
alias tmuxkill='tmux kill-session -t'
alias spicedefaultport='spicy -f spice://127.0.0.1 -p 3001'
alias virt-viewer-local='virt-viewer --connect qemu:///session'
alias scrot-fullscreen='scrot ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias scrot-selection='scrot -s ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias youtube-dlmp3="youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3"
alias qemu-snapshot-create="qemu-img create -f qcow2 -b image_file snapshot.img"
alias gmpv="gnome-mpv"
alias tar-multithreaded='tar -I pigz'
alias rm='rm -I'
alias virsh='sudo virsh'
PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin
export path

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
	sudo apt update
	sudo apt upgrade
	sudo apt dist-upgrade
	sudo apt autoremove
	sudo apt clean
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

# Alias vi to vim.
alias vi='vim'

#FZF
#export FZF_DEFAULT_OPTS='--height 40% --border'
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
