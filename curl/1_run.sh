#!/bin/bash


N=100
URL="http://speed.hetzner.de/1GB.bin"

OUTFILE="results_pr.txt"

for i in $(seq $N) ; do
    echo "Repetition $i"
    LC_ALL="en_US.UTF-8" curl -s -w "%{stderr}%{speed_download}\n" -o /dev/null $URL 2>> $OUTFILE

done
