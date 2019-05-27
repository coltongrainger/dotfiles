export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/scripts:$HOME/.cabal/bin
export R_HOME=/usr/lib/R
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export GPG_AGENT_INFO=$HOME/.gnupg/S.gpg-agent
export VIMRUNTIME=/usr/share/vim/vim81

PATH="/home/colton/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/colton/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/colton/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/colton/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/colton/perl5"; export PERL_MM_OPT;

# Initialize fuzzy find.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# renames
alias dropbox='python $HOME/.local/dropbox.py start &'
alias vpn='/opt/cisco/anyconnect/bin/vpn'
alias vpnui='/opt/cisco/anyconnect/bin/vpnui'

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

# https://superuser.com/questions/665274/how-to-make-ls-color-its-output-by-default-without-setting-up-an-alias
alias grep='grep -i --color'

# Colorize the ls output.
alias ls='ls --color=auto'

# Use a long listing format.
alias ll='ls -la'
eval $(dircolors ~/.dir_colors)

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
