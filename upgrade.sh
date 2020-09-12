#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_YELLOW='\e[0;33m'
TEXT_RED='\e[1;31m'
TEXT_GREEN='\e[1;32m'

sudo apt-get update
echo -e $TEXT_YELLOW
echo 'APT update finished...'
echo -e $TEXT_RESET

sudo apt-get dist-upgrade -y
echo -e $TEXT_YELLOW
echo 'APT distributive upgrade finished...'
echo -e $TEXT_RESET

sudo apt-get upgrade -y
echo -e $TEXT_YELLOW
echo 'APT upgrade finished...'
echo -e $TEXT_RESET

sudo apt-get autoremove -y
echo -e $TEXT_YELLOW
echo 'APT auto remove finished...'
echo -e $TEXT_RESET

if [ -f /var/run/reboot-required ]; then
    echo -e $TEXT_RED
    echo 'Reboot required!'
    echo ""
    echo 'Reboot now? (y/n)' && read x && [[ "$x" == "y" ]] && sudo reboot now;
    echo ""
    echo -e $TEXT_RESET
else
    echo -e $TEXT_GREEN
    echo 'No reboot required...'
    printf 'Have a good day \e[33m\U1F600\n'
    echo ""
    echo -e $TEXT_RESET
fi
