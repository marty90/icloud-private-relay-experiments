## iCloud Private Relay Experiments

### Prerequisites

You need:
* A MacOS PC with OS version Monterrey
* An iCloud+ subscription
* BrowserTime installed. Install it in the current directory with `npm install browsertime`
* You must enable the 'Allow Remote Automation' option in Safari's Develop menu to control Safari via WebDriver.
* Notice that the `SpeedIndex` feature may be wrongly use python2 while it needs python3. python command should point to 'python3'. I made `ln -s ../Cellar/python@3.9/3.9.12/bin/python3 /usr/local/bin/python`.
* You need `ffmpeg` for the SpeedInex and ImageMagic for proccessing it (install with `brew install imagemagick`)

You may need to customize the strings in `activate-private-relay.scpt` and `deactivate-private-relay.scpt` to you system language.

### How to run these experiments
TBD
