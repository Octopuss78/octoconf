## Description

This repository contains all my useful configuration files for my working environment (i3, nvim).

This repository is a fork of  s4tboys's i3_conf: https://github.com/s4tb0y/i3_conf/tree/main.

## Installation
octoconf.sh is a script that installs all dependencies and configurations automatically for a fresh installation.
This script only works for Arch-based Distributions.
To use it, just clone the repository and launch octoconf.sh to use automatic setup:

`git clone https://github.com/Octopuss78/octoconf.git
cd octoconf
chmod +x ./octoconf.sh
./octoconf.sh
`
## Monitors Module
I added a Monitors module that helps you to select which monitor to use using rofi's dmenu mode and i3block implemented with a wrapper of xrandr (still under development).
You can switch between Single Screen, Duplicate and Dual Screen mode.

