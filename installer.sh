#!/usr/bin/env bash

## Clone the repo
git clone https://github.com/kamranahmedse/git-standup.git --depth=1 || { echo >&2 "Clone failed with $?"; exit 1; }
cd git-standup
make install || { echo >&2 "Clone failed with $?"; exit 1; }
cd ..
rm -rf git-standup
