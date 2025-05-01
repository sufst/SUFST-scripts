#!/bin/sh

#
# Initialises ~/.config/kicad/<version> and 
# copies the default lib tables from
# /usr/share/kicad/template/ to that directory
#

# run kicad-cli once to generate .config/kicad/<version> then copy default lib tables
kicad-cli -v

for version in ~/.config/kicad/*; do 
    cp /usr/share/kicad/template/*-lib-table "$version/"
done
