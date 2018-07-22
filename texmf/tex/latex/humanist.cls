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
\RequirePackage[mono,varqu,varl,scaled=0.95]{zi4}

% For metadata (date, filename, pages)
\RequirePackage[english]{datetime2}
\RequirePackage{lastpage}
\RequirePackage{currfile}

% set \today as YYYY-MM-DD
\DTMsetdatestyle{iso}

% header
\RequirePackage{fancyhdr}

% first page
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhfoffset[R]{\marginparsep}
  \fancyhfoffset[R]{\marginparwidth}
  \fancyhfoffset[L]{\marginparsep}
  \fancyhfoffset[L]{\marginparwidth}
  \fancyhf{}
  \rhead{
    \vspace{-24pt}
      \texttt{generated:}\\
      \texttt{\the\year-\ifnum\month<10\relax0\fi\the\month-\ifnum\day<10\relax0\fi\the\day}\\
      \texttt{p.~\thepage/\pageref{LastPage}}
  }
  \ifnum\pdfstrcmp{\currfilename}{input.tex}=0
  \else
    \lhead{
      \vspace{-24pt}\texttt{\currfilename}\\
    }
  \fi
}

% header now on title page
\let\oldmake\maketitle
\renewcommand{\maketitle}{\oldmake\thispagestyle{plain}}

% remaining pages
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhfoffset[R]{\marginparsep}
\fancyhfoffset[R]{\marginparwidth}
\fancyhfoffset[L]{\marginparsep}
\fancyhfoffset[L]{\marginparwidth}
\fancyhf{}
  \rhead{
    \vspace{-24pt}
      \texttt{\the\year-\ifnum\month<10\relax0\fi\the\month-\ifnum\day<10\relax0\fi\the\day}\\
      \texttt{p.~\thepage/\pageref{LastPage}}
  }
