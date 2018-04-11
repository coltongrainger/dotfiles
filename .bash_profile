# load bash setup
[[ -f "$HOME//.bashrc" ]] && . ~/.bashrc

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

export PATH="/usr/local/opt/openssl/bin:$PATH"
