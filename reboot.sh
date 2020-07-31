#!/bin/bash

TEXT_RESET='\e[0m'
TEXT_RED='\e[1;31m'
TEXT_GREEN='\e[1;32m'

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
