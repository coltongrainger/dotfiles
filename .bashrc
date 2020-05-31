export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/bin/scripts
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:/opt/webwork/webwork2/bin
export PATH=$PATH:/home/colton/fy/20/mathbook/script
# export GOROOT=/usr/local/go
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export R_HOME=/usr/lib/R
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent
export VIMRUNTIME=/usr/share/vim/vim81
# https://stackoverflow.com/questions/18247333/python-pythonpath-in-linux
export PYTHONPATH=/.local/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=/.local/lib/python3.6/site-packages:$PYTHONPATH
export PYTHONPATH=/.local/lib/python3.7/site-packages:$PYTHONPATH
export PYTHONPATH=$HOME/fy/20/rda-image-archive/script:$PYTHONPATH
export WEBWORK_ROOT=/opt/webwork/webwork2
export PG_ROOT=/opt/webwork/pg
# Perl automagic
PATH="/home/colton/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/colton/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/colton/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/colton/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/colton/perl5"; export PERL_MM_OPT;
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export ECLIPSE_HOME=$HOME/.local/eclipse/java-2019-12/eclipse
# export JUPYTER_PATH=$HOME/fy/20/rda-image-archive/script:$JUPYTER_PATH
export VISUAL=vim
export EDITOR="$VISUAL"
export LESS="-R"

function margs {
   echo $(gpg -dq /home/colton/.ssh/mysql-args.txt.gpg)
}

# Initialize fuzzy find.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# renames
alias dropbox='python $HOME/.local/dropbox.py start &'
alias vpn='/opt/cisco/anyconnect/bin/vpn'
alias vpnui='/opt/cisco/anyconnect/bin/vpnui'
alias eclimd='$ECLIPSE_HOME/eclimd'

# https://www.jefftk.com/p/you-should-be-logging-shell-history
promptFunc() {
    # Right before prompting for the next command, save the previous
    # command in a file. See <https://stackoverflow.com/questions/7216358>.
    echo "$(date +%Y-%m-%dT%H:%M:%S%z) $(hostname) $PWD $(history 1)" \
        >> ~/.full_history
}
PROMPT_COMMAND=promptFunc

# Search ~/.full_history, because I can't remember what exiftool options do what. <ccg, 2019-04-21> #
function fh {
   grep --text $1 $HOME/.full_history
}

# Free up CTRL-Q and CTRL-S. 
# https://vi.stackexchange.com/questions/3699/
# Are we on a terminal?
if [ -t 0 ];
then
    stty sane
    stty stop ''
    stty start ''
    stty werase ''
fi

# colors
eval $(dircolors ~/.dir_colors)

# https://superuser.com/questions/665274/how-to-make-ls-color-its-output-by-default-without-setting-up-an-alias
alias grep='grep -i --color'

# Colorize the ls output.
alias ls='ls --color=auto'

# Use a long listing format.
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

# Open the OED with Wine.
alias oed="wine start /unix '/opt/oed/swhx.exe'"

# Countdown N minutes.
function countdown(){
   minutes=$1
   seconds=$minutes*60
   date1=$((`date +%s` + $seconds));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
   zenity --warning --text "${minutes} minute(s) passed."
}

# Extract compressed files. 
# https://github.com/rpellerin/dotfiles/blob/master/.aliases
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# TODO Remove.
# https://gist.github.com/Dnomyar/9c289fcc2668b59e1ffb
# function open {
#     while [ "$1" ] ; do
#         xdg-open $1 &> /dev/null
#         shift # shift décale les param
#     done
# }

# TODO Remove.
# function test-microphone {
#     arecord -vvv -f dat /dev/null
# }

# TODO Remove. I can't read .mbox files---it's infuriating. <ccg, 2019-04-21> #
# function om {
#    grep -h -n -C 20 --color=always --text\
#       $1 $HOME/rec/communication/2019-01-09-old-email.mbox.stripped
# }

# TODO Remove confusing TEXINPUTS path. I use ~/texmf anyways. <ccg, 2019-04-21> #
# export TEXINPUTS=".:~/.texmf:"

# TODO Remove TMSU.
# export GOPATH=$HOME/.local/TMSU

# https://gist.github.com/Dnomyar/9c289fcc2668b59e1ffb
function githelp {
    echo ""
    echo "git clone http://... [repo-name]"
    echo "git init [repo-name]"
    echo ""
    echo "git add -A <==> git add . ; git add -u # Add to the staging area (index)"
    echo ""
    echo "git commit -m 'message' -a"
    echo "git commit -m 'message' -a amend"
    echo ""
    echo "git status"
    echo "git log stat # Last commits, stat optional"
    echo "git ls-files"
    echo "git diff HEAD~1..HEAD"
    echo ""
    echo "git push origin master"
    echo "git push origin master:master"
    echo ""
    echo "git remote add origin http://..."
    echo "git remote set-url origin git://..."
    echo ""
    echo "git stash"
    echo "git pull origin master"
    echo "git stash list ; git stash pop"
    echo ""
    echo "git submodule add /absolute/path repo-name"
    echo "git submodule add http://... repo-name"
    echo ""
    echo "git checkout -b new-branch <==> git branch new-branch ; git checkout new-branch"
    echo "git merge old-branch"
    echo "git branch local_name origin/remote_name # Associate branches"
    echo ""
    echo "git update-index assume-unchanged <file> # Ignore changes"
    echo "git rm cached <file> # Untrack a file"
    echo ""
    echo "git reset hard HEAD # Repair what has been done since last commit"
    echo "git revert HEAD # Repair last commit"
    echo "git checkout [file] # Reset a file to its previous state at last commit"
    echo ""
    echo "git tag # List"
    echo "git tag v0.5 # Lightwieght tag"
    echo "git tag -a v1.4 -m 'my version 1.4' # Annotated tag"
    echo "git push origin v1.4 # Pushing"
    echo ""
    echo "HOW TO RENAME A BRANCH LOCALLY AND REMOTELY"
    echo "git branch -m old_name new_name"
    echo "git push origin new_name"
    echo "git push origin :old_name"
    echo ""
    echo "Each other client of the repository has to do:"
    echo "git fetch origin ; git remote prune origin"
    echo ""
}
