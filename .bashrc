# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/bin:$PATH"
export EDITOR='nvim'

source "./.alias"

sdtm() {
    start_dir="$(pwd)"
    cd ~
    local full_path=$(find -type d | fzf)
    cd $full_path
    local session_name=$(basename "$full_path")
    tmux new-session -s $session_name
    if [ $? -ne 0 ]; then
        echo "Session with $session_name at '$full_path' already exists. [a]ttach, [n]ame or [q]uit"
        read choice
        if [ "$choice" = 'a' ]; then
            tmux attach-session -t $session_name
        elif [ "$choice" = 'n' ]; then
            echo -n 'Give a new name: '
            read session_name
            tmux new-session -s $session_name
        elif [ "$choice" = 'q' ]; then
            echo 'Quit... Returning...'
            cd $start_dir
        fi
    fi
}

green=$(tput setaf 2)
blue=$(tput setaf 4)
bold=$(tput bold)
reset=$(tput sgr0)

# Load functions for git information.
. ~/.git-prompt.sh

set_ps1() {
    PS1="\[$green\]\w\[$blue\]$(__git_ps1)\[$reset\] > "
}

PROMPT_COMMAND=set_ps1

source /usr/share/git/completion/git-completion.bash

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PNPM_HOME="/home/flaminger/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
