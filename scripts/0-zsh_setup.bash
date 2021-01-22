#!/bin/bash

#SUMMARY Install and configure zsh and oh my zsh with custom theme
sudo apt -y install zsh
export RUNZSH=no
yes | sudo sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
./omz_setup.bash
