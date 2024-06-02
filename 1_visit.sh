#!/bin/bash

WEBSITE_LIST="lists/it.txt"
NUM=5
HEAD=100
IFACE=en0
IS_SPEEDTEST=true
# Remove status with: rm -rf browsertime-results/* results-*

osversion=$(sw_vers | grep "ProductVersion:" | cut -f3 | cut -d. -f1)

# Privacy Relay
if [[ $osversion -ge 13 ]]; then
    osascript switch_icloud_pr/activate-private-relay-sonoma.scpt
    osascript switch_icloud_pr/quit-preferences-sonoma.scpt
else
    osascript switch_icloud_pr/activate-private-relay.scpt
    osascript switch_icloud_pr/quit-preferences.scpt
fi

mkdir -p results-pr
tcpdump -i $IFACE -w results-pr/capture-${RANDOM}.pcap &
for i in $(seq $NUM); do
    for website in $(cat $WEBSITE_LIST | grep -v '#' | head -n $HEAD); do
        mkdir -p results-pr/$website
        echo $website
        ~/node_modules/browsertime/bin/browsertime.js -b safari https://$website \
                                                      -n 1 --viewPort=1600x1200 --prettyPrint \
                                                      --timeouts.pageLoad 30000 --timeouts.pageCompleteCheck 30000 \
                                                      --safari.diagnose
        killall Safari
        cp -r ~/Library/Logs/com.apple.WebDriver/$(ls -t ~/Library/Logs/com.apple.WebDriver/ | head -1) results-pr/$website
    done

    if [[ $IS_SPEEDTEST = true ]]; then 
        python <<EOF
from speedtest_support import run_speedtest

run_speedtest(True)
EOF
    fi

    cp -r browsertime-results/$website results-pr
    rm -rf browsertime-results/$website
    HTTPSTAT_METRICS_ONLY=true httpstat https://$website >results-pr/$website/httpstat.json

done
killall tcpdump

# No Privacy Relay
if [[ $osversion -ge 13 ]]; then
    osascript switch_icloud_pr/deactivate-private-relay-sonoma.scpt
    osascript switch_icloud_pr/quit-preferences-sonoma.scpt
else
    osascript switch_icloud_pr/deactivate-private-relay.scpt
    osascript switch_icloud_pr/quit-preferences.scpt
fi

mkdir -p results-no-pr
tcpdump -i $IFACE -w results-no-pr/capture-${RANDOM}.pcap &
for i in $(seq $NUM); do
    for website in $(cat $WEBSITE_LIST | grep -v '#' | head -n $HEAD); do
        mkdir -p results-no-pr/$website
        echo $website
        ~/node_modules/browsertime/bin/browsertime.js -b safari https://$website \
                                                      -n 1 --viewPort=1600x1200 --prettyPrint \
                                                      --timeouts.pageLoad 30000 --timeouts.pageCompleteCheck 30000 \
                                                      --safari.diagnose
        killall Safari
        cp -r ~/Library/Logs/com.apple.WebDriver/$(ls -t ~/Library/Logs/com.apple.WebDriver/ | head -1) results-no-pr/$website
    done

    if [[ $IS_SPEEDTEST = true ]]; then 
        python <<EOF
from speedtest_support import run_speedtest

run_speedtest(False)
EOF
    fi

    cp -r browsertime-results/$website results-no-pr
    rm -rf browsertime-results/$website
    HTTPSTAT_METRICS_ONLY=true httpstat https://$website >results-no-pr/$website/httpstat.json

done
killall tcpdump

rm -rf browsertime-results
