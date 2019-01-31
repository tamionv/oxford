#!/bin/bash

while read p; do
    x=${p//_/\\_}
    y=${x/*\/*\//}
    echo \\subsection\{\\textbf\{\\texttt\{$y\}\}\}
    echo \\begin\{lstlisting\}\[language=pascal\]
    cat $p
    echo \\end\{lstlisting\}
done <newtests
