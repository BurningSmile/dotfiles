#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

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
alias spicedefaultport='spicy -f spice://127.0.0.1 -p 3001'
alias virt-viewer-local='virt-viewer --connect qemu:///session'
alias scrot-custom='scrot ~/Pictures/Scrot/%b%d::%H%M%S.png' 
alias youtube-dlmp3="youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3"
alias qemu-snapshot-create="qemu-img create -f qcow2 -b image_file snapshot.img"
alias gmpv="gnome-mpv"
alias tar-multithreaded='tar -I pigz'
alias rm='rm -I'

# Change prefix key for local tmux when using tmux in a ssh session.
ssh-tmux() {
tmux source-file ~/.tmux-ssh.conf 
ssh $1 
tmux source-file ~/.tmux.conf
}

# Update pacman mirrors
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

# Mpd Start
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

# Run ls on a directory cd.
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
        echo;
        ls --color=auto --color=auto;
    fi
}

# Alias vi to vim.
alias vi='vim'

# Display path of current working directory.
PS1='\u@\h:\w\$ '

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
