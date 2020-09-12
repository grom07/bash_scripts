#!/bin/sh

cpuinfo=`cat /proc/cpuinfo | grep "Revision"|awk -F': ' '{printf $2}'`
case ${cpuinfo} in
    "0002" )
        echo "Revision : 0002 (Model B Rev 1, 256MB)" ;;
    "0003" )
        echo "Revision : 0003 (Model B Rev 1, ECN0001 (no fuses, D14 removed), 256MB)" ;;
    "0004" )
        echo "Revision : 0004 (Model B Rev 2, 256MB)" ;;
    "0005" )
        echo "Revision : 0005 (Model B Rev 2, 256MB)" ;;
    "0006" )
        echo "Revision : 0006 (Model B Rev 2, 256MB)" ;;
    "0007" )
        echo "Revision : 0007 (Model A, 256MB)" ;;
    "0008" )
        echo "Revision : 0008 (Model A, 256MB)" ;;
    "0009" )
        echo "Revision : 0009 (Model A, 256MB)" ;;
    "000d" )
        echo "Revision : 000d (Model B Rev 2, 512MB)" ;;
    "000e" )
        echo "Revision : 000e (Model B Rev 2, 512MB)" ;;
    "000f" )
        echo "Revision : 0009 (Model B Rev 2, 512MB)" ;;
    "0010" )
        echo "Revision : 0010 (Model B+, 512MB)" ;;
    "0013" )
        echo "Revision : 0013 (Model B+, 512MB)" ;;
    "900032" )
        echo "Revision : 900032 (Model B+, 512MB)" ;;
    "0011" )
        echo "Revision : 0011 (Compute Module, 512MB)" ;;
    "0014" )
        echo "Revision : 0014 (Compute Module, (Embest, China), 512MB)" ;;
    "0012" )
        echo "Revision : 0012 (Model A+, 256MB)" ;;
    "0015" )
        echo "Revision : 0015 (Model A+, (Embest, China), 256MB)" ;;
    "0015" )
        echo "Revision : 0015 (Model A+, (Embest, China), 512MB)" ;;
    "a01041" )
        echo "Revision : a01041 (Pi 2 Model B v1.1, (Sony, UK), 1GBB)" ;;
    "a01041" )
        echo "Revision : a01041 (Pi 2 Model B v1.1, (Embest, China), 1GBB)" ;;
    "a22042" )
        echo "Revision : a22042 (Pi 2 Model B v1.2, (Sony, UK), 1GBB)" ;;
    "900092" )
        echo "Revision : 900092 (Pi Zero v1.2, 512MB)" ;;
    "900093" )
        echo "Revision : 900093 (Pi Zero v1.3, 512MB)" ;;
    "9000C1" )
        echo "Revision : 9000C1 (Pi Zero W, 512MB)" ;;
    "a02082" )
        echo "Revision : a02082 (Pi 3 Model B, (Sony, UK), 1GB)" ;;
    "a22082" )
        echo "Revision : a22082 (Pi 3 Model B, (Embest, China), 1GBB)" ;;
    "a020d3" )
        echo "Revision : a020d3 (Pi 3 Model B+, (Sony, UK), 1GBB)" ;;
    * )
        echo "not a Pi?" ;;
esac
