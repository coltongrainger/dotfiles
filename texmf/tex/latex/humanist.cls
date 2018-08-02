% humanist style based on amsart
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{humanist}
    [2018-06-28 Humanist style for coursework, handouts]

% parent style
\LoadClass[12pt,oneside]{amsart}

% Fira Sans, Euler Math, Inconsolata
\RequirePackage[T1]{fontenc}
\RequirePackage[sfdefault,scaled=0.85]{FiraSans}
\RequirePackage[small,euler-digits]{eulervm}
\RequirePackage{textcomp}
%\RequirePackage[mono,varqu,varl,scaled=0.9]{zi4}

% metadata: date and filename
\RequirePackage[english]{datetime2}
\RequirePackage{currfile}

% set \today as YYYY-MM-DD
\DTMsetdatestyle{iso}
\renewcommand{\datename}{\textit{Date:}}
\thanks{\textit{Compiled:}
\today\ifnum\pdfstrcmp{\currfilename}{input.tex}=0\else\ from \texttt{\currfilename}\fi}

% header
%\RequirePackage{fancyhdr}
%% first page
%\fancypagestyle{plain}{
%  \renewcommand{\headrulewidth}{0pt}
%  \renewcommand{\footrulewidth}{0pt}
%  \fancyhfoffset[R]{\marginparsep}
%  \fancyhfoffset[R]{\marginparwidth}
%  \fancyhfoffset[L]{\marginparsep}
%  \fancyhfoffset[L]{\marginparwidth}
%  \fancyhf{}
%  \rhead{
%    \vspace{-24pt}\ttfamily\scriptsize
%    generated:\\
%    metadata:
%    \the\year-\ifnum\month<10\relax0\fi\the\month-\ifnum\day<10\relax0\fi\the\day~\thepage/\pageref{LastPage}
%  }
%}
%
%% header now on title page
%\let\oldmake\maketitle
%\renewcommand{\maketitle}{\oldmake\thispagestyle{plain}}
%
%% remaining pages
%\pagestyle{fancy}
%\renewcommand{\headrulewidth}{0pt}
%\renewcommand{\footrulewidth}{0pt}
%\fancyhfoffset[R]{\marginparsep}
%\fancyhfoffset[R]{\marginparwidth}
%\fancyhfoffset[L]{\marginparsep}
%\fancyhfoffset[L]{\marginparwidth}
%\fancyhf{}
%  \rhead{
%    \vspace{-24pt}\ttfamily\scriptsize
%    \the\year-\ifnum\month<10\relax0\fi\the\month-\ifnum\day<10\relax0\fi\the\day~\thepage/\pageref{LastPage}
%  }
%}
