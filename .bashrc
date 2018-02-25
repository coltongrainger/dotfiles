# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# trying to setup dotfiles on github
alias config='/usr/bin/git --git-dir=/Users/colton/.cfg/ --work-tree=/Users/colton'

# Modified from <https://www.jefftk.com/p/you-should-be-logging-shell-history>
promptFunc() {
    # right before prompting for the next command, save the previous
    # command in a file.
    echo "$(date +%Y-%m-%dT%H:%M:%S%z) $(hostname) $PWD $(history 1)" \
        >> ~/.full_history
}
PROMPT_COMMAND=promptFunc
