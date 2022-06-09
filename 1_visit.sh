#!/bin/bash

WEBSITE_LIST="lists/websites.txt"
NUM=3
HEAD=100
IFACE=en31
# Remove status with: rm -rf browsertime-results/* results-*

# No Privacy Relay
osascript activate-private-relay.scpt
osascript quit-preferences.scpt
mkdir -p results-pr
tcpdump -i  $IFACE -w results-pr/capture-${RANDOM}.pcap &
for website in $( cat $WEBSITE_LIST | grep -v '#' | head -n $HEAD) ; do
    mkdir -p results-pr/$website
    echo $website
    for i in $( seq $NUM ) ; do
        ./node_modules/browsertime/bin/browsertime.js -b safari https://$website \
                                                      -n 1 --viewPort=1600x1200 --prettyPrint \
                                                      --timeouts.pageLoad 30000 --timeouts.pageCompleteCheck 30000 \
                                                      --safari.diagnose
        killall Safari
        cp -r ~/Library/Logs/com.apple.WebDriver/$( ls -t  ~/Library/Logs/com.apple.WebDriver/ | head -1 ) results-pr/$website
    done
    cp -r browsertime-results/$website results-pr
    rm -rf browsertime-results/$website
    HTTPSTAT_METRICS_ONLY=true httpstat https://$website > results-pr/$website/httpstat.json

done
killall tcpdump



# No Privacy Relay
osascript deactivate-private-relay.scpt
osascript quit-preferences.scpt
mkdir -p results-no-pr
tcpdump -i  $IFACE -w results-no-pr/capture-${RANDOM}.pcap &
for website in $( cat $WEBSITE_LIST | grep -v '#' | head -n $HEAD) ; do

    echo $website
    for i in $( seq $NUM ) ; do
        mkdir -p results-no-pr/$website
        ./node_modules/browsertime/bin/browsertime.js -b safari https://$website \
                                                      -n 1 --viewPort=1600x1200 --prettyPrint \
                                                      --timeouts.pageLoad 30000 --timeouts.pageCompleteCheck 30000 \
                                                      --safari.diagnose
        
        killall Safari
        cp -r ~/Library/Logs/com.apple.WebDriver/$( ls -t  ~/Library/Logs/com.apple.WebDriver/ | head -1 ) results-no-pr/$website
    done
    cp -r browsertime-results/$website results-no-pr
    rm -rf browsertime-results/$website
    HTTPSTAT_METRICS_ONLY=true httpstat https://$website > results-no-pr/$website/httpstat.json

done
killall tcpdump

