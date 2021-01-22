#!/bin/bash

#SUMMARY Install Flatpak and add Flatpak Repo
sudo apt -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
