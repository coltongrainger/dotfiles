% humanist style based on amsart
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{humanist}
    [2018-06-28 Humanist style for coursework, handouts]

% parent style
\LoadClass[12pt]{amsart}
\RequirePackage{fullpage}

% Fira Sans, Euler Math, Inconsolata
\RequirePackage[T1]{fontenc}
\RequirePackage[sfdefault,scaled=0.85]{FiraSans}
\RequirePackage[small,euler-digits]{eulervm}
\RequirePackage{textcomp}
%\RequirePackage[mono,varqu,varl,scaled=0.9]{zi4} decided against it

% metadata: date and filename
\RequirePackage[english]{datetime2}
\RequirePackage{currfile}

% set \today as YYYY-MM-DD
\DTMsetdatestyle{iso}
\renewcommand{\datename}{\textit{Date:}}
\thanks{\textit{Compiled:}
\today\ifnum\pdfstrcmp{\currfilename}{input.tex}=0\else\ from \texttt{\currfilename}\fi}
