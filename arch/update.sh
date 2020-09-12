#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED_B='\e[1;31m'

sudo pacman -Syu
echo -e $TEXT_YELLOW
echo 'Pacman update finished...'
echo -e $TEXT_RESET

yay -Syu
echo -e $TEXT_YELLOW
echo 'Yay ARC update finished...'
echo -e $TEXT_RESET

if [ -f /var/run/reboot-required ]; then
    echo -e $TEXT_RED_B
    echo 'Reboot required!'
    echo ""
    echo 'Reboot now? (y/n)' && read x && [[ "$x" == "y" ]] && sudo reboot now;
    echo ""
    echo -e $TEXT_RESET
fi
