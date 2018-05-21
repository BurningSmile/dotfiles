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
alias removeorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias ls='ls --color=auto'
alias rdesktop-localhost-default-port='rdesktop -g 1920x1080 -P -z -x l -r sound:off localhost:3389'
alias tmuxkill='tmux kill-session -t'
alias spicedefaultport='spicy -f spice://127.0.0.1 -p 5900'
alias virt-viewer-local='virt-viewer --connect qemu:///session'
alias scrot-fullscreen='scrot ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias scrot-selection='scrot -s ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias youtube-dlmp3="youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3"
alias qemu-snapshot-create="qemu-img create -f qcow2 -b image_file snapshot.img"
alias gmpv="gnome-mpv"
alias tar-multithreaded='tar -I pigz'
alias rm='rm -I'
alias virsh='sudo virsh'

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
	sudo apt dist-upgrade
	sudo apt autoremove
	sudo apt clean
    sudo snap refresh
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

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
