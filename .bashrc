export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/scripts:$HOME/.cabal/bin
export R_HOME=/usr/lib/R
export GOROOT=/usr/local/go
export GOPATH=$HOME/.local/TMSU
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export TEXINPUTS=".:~/.texmf:"
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' 

# open the OED with Wine
alias oed="wine start /unix '/opt/oed/swhx.exe'"

# https://www.jefftk.com/p/you-should-be-logging-shell-history
promptFunc() {
    # right before prompting for the next command, save the previous
    # command in a file. see <https://stackoverflow.com/questions/7216358>
    echo "$(date +%Y-%m-%dT%H:%M:%S%z) $(hostname) $PWD $(history 1)" \
        >> ~/.full_history
}
PROMPT_COMMAND=promptFunc

function fh {
   grep --text $1 $HOME/.full_history
}

function om {
   grep -h -n -C 20 --color=always --text\
      $1 $HOME/rec/communication/2019-01-09-old-email.mbox.stripped
}

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

# https://gist.github.com/Dnomyar/9c289fcc2668b59e1ffb
function open {
    while [ "$1" ] ; do
        xdg-open $1 &> /dev/null
        shift # shift décale les param
    done
}

function test-microphone {
    arecord -vvv -f dat /dev/null
}

function countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

# https://gist.github.com/Dnomyar/9c289fcc2668b59e1ffb
function githelp {
    echo "-------------------------------------------------------------------------------"
    echo "git clone http://... [repo-name]"
    echo "git init [repo-name]"
    echo "-------------------------------------------------------------------------------"
    echo "git add -A <==> git add . ; git add -u # Add to the staging area (index)"
    echo "-------------------------------------------------------------------------------"
    echo "git commit -m 'message' -a"
    echo "git commit -m 'message' -a --amend"
    echo "-------------------------------------------------------------------------------"
    echo "git status"
    echo "git log --stat # Last commits, --stat optional"
    echo "git ls-files"
    echo "git diff HEAD~1..HEAD"
    echo "-------------------------------------------------------------------------------"
    echo "git push origin master"
    echo "git push origin master:master"
    echo "-------------------------------------------------------------------------------"
    echo "git remote add origin http://..."
    echo "git remote set-url origin git://..."
    echo "-------------------------------------------------------------------------------"
    echo "git stash"
    echo "git pull origin master"
    echo "git stash list ; git stash pop"
    echo "-------------------------------------------------------------------------------"
    echo "git submodule add /absolute/path repo-name"
    echo "git submodule add http://... repo-name"
    echo "-------------------------------------------------------------------------------"
    echo "git checkout -b new-branch <==> git branch new-branch ; git checkout new-branch"
    echo "git merge old-branch"
    echo "git branch local_name origin/remote_name # Associate branches"
    echo "-------------------------------------------------------------------------------"
    echo "git update-index --assume-unchanged <file> # Ignore changes"
    echo "git rm --cached <file> # Untrack a file"
    echo "-------------------------------------------------------------------------------"
    echo "git reset --hard HEAD # Repair what has been done since last commit"
    echo "git revert HEAD # Repair last commit"
    echo "git checkout [file] # Reset a file to its previous state at last commit"
    echo "-------------------------------------------------------------------------------"
    echo "git tag # List"
    echo "git tag v0.5 # Lightwieght tag"
    echo "git tag -a v1.4 -m 'my version 1.4' # Annotated tag"
    echo "git push origin v1.4 # Pushing"
    echo "-------------------------------------------------------------------------------"
    echo "HOW TO RENAME A BRANCH LOCALLY AND REMOTELY"
    echo "git branch -m old_name new_name"
    echo "git push origin new_name"
    echo "git push origin :old_name"
    echo "------"
    echo "Each other client of the repository has to do:"
    echo "git fetch origin ; git remote prune origin"
    echo "-------------------------------------------------------------------------------"
}

PATH="/home/colton/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/colton/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/colton/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/colton/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/colton/perl5"; export PERL_MM_OPT;
