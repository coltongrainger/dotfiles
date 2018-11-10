# Mnemosyne configuration file.

# This file contains settings which we deem to be too specialised to be
# accesible from the GUI. However, if you use some of these settings, feel
# free to inform the developers so that it can be re-evaluated if these
# settings need to be exposed in the GUI.

# Science server. Only change when prompted by the developers.
science_server = "mnemosyne-proj.dyndns.org:80"

# Set to True to prevent you from accidentally revealing the answer when
# clicking the edit button.
only_editable_when_answer_shown = False

# Set to False if you don't want the tag names to be shown in the review
# window.
show_tags_during_review = True

# The number of daily backups to keep. Set to -1 for no limit.
max_backups = 10

# Start the card browser with the last used colum sort. Can have a serious
# performance penalty for large databases.
start_card_browser_sorted = False

# The moment the new day starts. Defaults to 3 am. Could be useful to change
# if you are a night bird. You can only set the hours, not minutes, and
# midnight corresponds to 0.
day_starts_at = 3

# On mobile clients with slow SD cards copying a large database for the backup
# before sync can take longer than the sync itself, so we offer reckless users
# the possibility to skip this.
backup_before_sync = True

# Latex preamble. Note that for the pre- and postamble you need to use double
# slashes instead of single slashes here, to have them escaped when Python
# reads them in.
latex_preamble = r"""
\documentclass{article}
\usepackage[textwidth=4.9cm]{geometry}
\usepackage{amssymb,amsmath}
\usepackage{mathrsfs}

% macros added in chronological order
% summer 2016
\newcommand{\eps}{\varepsilon}
\newcommand{\id}{\text{id}}
\newcommand{\TOE}{\mathscr{T}}
\newcommand{\Cl}{\overline}

%% bold math capitals
\newcommand{\BB}{\mathbf{B}}
\newcommand{\CC}{\mathbf{C}}
\newcommand{\DD}{\mathbf{D}}
\newcommand{\EE}{\mathbf{E}}
\newcommand{\FF}{\mathbf{F}}
\newcommand{\GG}{\mathbf{G}}
\newcommand{\HH}{\mathbf{H}}
\newcommand{\II}{\mathbf{I}}
\newcommand{\JJ}{\mathbf{J}}
\newcommand{\KK}{\mathbf{K}}
\newcommand{\LL}{\mathbf{L}}
\newcommand{\MM}{\mathbf{M}}
\newcommand{\NN}{\mathbf{N}}
\newcommand{\OO}{\mathbf{O}}
\newcommand{\PP}{\mathbf{P}}
\newcommand{\QQ}{\mathbf{Q}}
\newcommand{\RR}{\mathbf{R}}
\newcommand{\TT}{\mathbf{T}}
\newcommand{\UU}{\mathbf{U}}
\newcommand{\VV}{\mathbf{V}}
\newcommand{\WW}{\mathbf{W}}
\newcommand{\XX}{\mathbf{X}}
\newcommand{\YY}{\mathbf{Y}}
\newcommand{\ZZ}{\mathbf{Z}}

%% script math capitals
\newcommand{\sA}{\mathscr{A}}
\newcommand{\sB}{\mathscr{B}}
\newcommand{\sC}{\mathscr{C}}
\newcommand{\sD}{\mathscr{D}}
\newcommand{\sE}{\mathscr{E}}
\newcommand{\sF}{\mathscr{F}}
\newcommand{\sG}{\mathscr{G}}
\newcommand{\sH}{\mathscr{H}}
\newcommand{\sI}{\mathscr{I}}
\newcommand{\sJ}{\mathscr{J}}
\newcommand{\sK}{\mathscr{K}}
\newcommand{\sL}{\mathscr{L}}
\newcommand{\sM}{\mathscr{M}}
\newcommand{\sN}{\mathscr{N}}
\newcommand{\sO}{\mathscr{O}}
\newcommand{\sP}{\mathscr{P}}
\newcommand{\sQ}{\mathscr{Q}}
\newcommand{\sR}{\mathscr{R}}
\newcommand{\sS}{\mathscr{S}}
\newcommand{\sT}{\mathscr{T}}
\newcommand{\sU}{\mathscr{U}}
\newcommand{\sV}{\mathscr{V}}
\newcommand{\sW}{\mathscr{W}}
\newcommand{\sX}{\mathscr{X}}
\newcommand{\sY}{\mathscr{Y}}
\newcommand{\sZ}{\mathscr{Z}}

% more 2018-09-01 era
\providecommand{\abs}[1]{\left\lvert #1 \right\rvert}
\providecommand{\norm}[1]{\left\lVert #1 \rVert\right}
\renewcommand{\phi}{\varphi}
\newcommand{\eps}{\varepsilon}
\renewcommand{\emptyset}{\varnothing}

% group actions 2018-10-14
\providecommand{\Stab}[2]{\mathrm{Stab}_{#1} \left( #2 \right)}
\providecommand{\Norm}[2]{\mathrm{Norm}_{#1} \left( #2 \right)}

% sylow theory 2018-10-30
\providecommand{\Syl}[2]{\mathrm{Syl}_{ #1 }\left( #2 \right)}
\providecommand{\N}[2]{N_{ #1 }\left( #2 \right)}
\providecommand{\C}[2]{C_{ #1 }\left( #2 \right)}
\providecommand{\Aut}[1]{\mathrm{Aut}\left({ #1 }\right)}
\providecommand{\Inn}[1]{\mathrm{Inn}\left({ #1 }\right)}
\providecommand{\inn}[1]{\mathrm{inn}\left({ #1 }\right)}

% formatting
\pagestyle{empty}
\setlength{\parindent}{0in}
\begin{document}
\small
"""

# \usepackage[sfdefault,scaled=.85]{FiraSans}
# \usepackage{newtxsf} % or euler
# \usepackage{fourier}

# Latex postamble.
latex_postamble = r"""\end{document}"""

# Latex command.
latex = "latex -interaction=nonstopmode"

# Latex dvipng command.
dvipng = "dvipng -D 200 -T tight tmp.dvi"

