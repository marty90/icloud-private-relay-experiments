# iCloud Private Relay Experiments

This repository contains the dataset and the code used for the paper: _"Measuring the Performance of iCloud Private Relay"_, Martino Trevisan, Idilio Drago, Paul Schmitt, Francesco Bronzino, to appear in **PAM 2023**.

## Dataset

In the `data` folder, there are the datasets we collected for the paper, that were used to create the figures and draw conclusions. They are in plain `CSV` format and can be read with any tool, including Python Pandas.

## Prerequisites

The provided scripts visit a set of **websites** with and without the iCloud Private Relay. It drives Safari using BrowserTime and collects various metrics from the **visits**. Tested on MacOS Monterey 12.3.1 (21E258) and MacOS Sonoma 14.5 (23F79). The `curl` folder contains a simple script to record the time of **bulk HTTP downloads**.

For the **Ookla speed test experiments**, we used the [PySpeedTest](https://github.com/marty90/pyspeedtest) Python library. Speedtests can be performed directly from this repository; inside the cloned folder just launch

```
pip install git+https://github.com/marty90/pyspeedtest.git
```

You need:

- A MacOS PC with OS version Monterey or Sonoma
- An iCloud+ subscription
- BrowserTime installed. Install it in this project directory with `npm install browsertime`.
- `httpstat` installed (even if not mandatory). Install it with `brew`.
- You must enable the 'Allow Remote Automation' option in Safari's Develop menu in order to control Safari via WebDriver.
- Notice that the `SpeedIndex` feature may be wrongly use python2 while it needs python3. The `python` command should point to 'python3'. I made `ln -s ../Cellar/python@3.9/3.9.12/bin/python3 /usr/local/bin/python`.
- You need `ffmpeg` for the SpeedInex and ImageMagic for processing it (install with `brew install imagemagick`)

## How to run these experiments

You have to run the `1_visit.sh` script. The script visits the websites and store the results in the `results-pr` and `results-no-pr` directories.

- You may need to customize the strings in `activate-private-relay.scpt` and `deactivate-private-relay.scpt` to you system language. Test them to see if they activate/deactivate the Private Relay correctly.
- Also check in the above script the `PRIVACY_RELAY_INDEX`. It must match the Private Relay position in the System Preference -> Apple ID menu. Count starts from 1.
- Customize the variable `WEBSITE_LIST` to point to the desired website list. We have top 100 for Italy, France and US, according to SimilarWeb.
- Set the correct interface for `tcpdump` in the variable `IFACE`
- You can customize with `NUM` and `HEAD` the repetitions for each website and to possibly shorten the list, respectively.
- Set `IS_SPEEDTEST` to `false` if you want to run only the visits to the websites
