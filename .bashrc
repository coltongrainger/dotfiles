# trying to setup dotfiles on github
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Modified from <https://www.jefftk.com/p/you-should-be-logging-shell-history>
promptFunc() {
    # right before prompting for the next command, save the previous
    # command in a file. see <https://stackoverflow.com/questions/7216358>
    echo "$(date +%Y-%m-%dT%H:%M:%S%z) $(hostname) $PWD $(history 1)" \
        >> ~/.full_history
}
PROMPT_COMMAND=promptFunc

# most applications
export PATH=$PATH:$HOME/bin

# TeX
export PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias nbstrip_jq="jq --indent 1 \
    '(.cells[] | select(has(\"outputs\")) | .outputs) = []  \
    | (.cells[] | select(has(\"execution_count\")) | .execution_count) = null  \
    | .cells[].metadata = {} \
    '"
