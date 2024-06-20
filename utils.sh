#! /bin/sh

cut -s -d\" -f2 < ROM.vhd | sed s/_//g | cut -c 13- | python utils.py
