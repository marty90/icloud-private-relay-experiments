#!/bin/bash


N=100
URL="http://tstat.polito.it/tracce/Polito/2015/TCP/log_tcp_complete.xz"
OUTFILE="results_pr.txt"

for i in $(seq $N) ; do
    echo "Repetition $i"
    LC_ALL="en_US.UTF-8" curl -s -w "%{stderr}%{speed_download}\n" -o /dev/null $URL 2>> $OUTFILE

done