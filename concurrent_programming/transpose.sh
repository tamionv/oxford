#!/bin/sh
## TRANSPOSE A MATRIX
## ASSUMES ALL LINES HAVE THE SAME NUMBER OF FIELDS
## USAGE : transpose filename
# Source: <news:1993Jan30.150622%40gruc19.nor.chevron.com>

exec awk '
NR == 1 {
  n = NF
  for (i = 1; i <= NF; i++)
    row[i] = $i
  next
}
{
  if (NF > n)
    n = NF
  for (i = 1; i <= n; i++)
    row[i] = row[i] " " $i
}
END {
  for (i = 1; i <= n; i++)
    print row[i]
}' ${1+"$@"}
