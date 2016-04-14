#!/bin/bash

# ##########
#
# Génération des images bitmaps à partir des images SVG
# Usage : ./gen-images.sh NUMERO-CHAPITRE
#
# Ce script ne fonctionne pas sur OSX (malgré mes tentatives).
#
# Mars 2016, Nicolas Jeanmonod
#
# ##########

SCRIPT=`realpath $0`
CUR_DIR=`dirname $SCRIPT`
echo $CUR_DIR

if [[ "$OSTYPE" == darwin14 ]]; then
	shopt -s expand_aliases
	alias inkscape="/Applications/inkscape.app/Contents/Resources/bin/inkscape"
fi

case "$1" in

101)
cd $CUR_DIR/../cours/104/
;;

*)
echo "Usage: ./gen-images.sh NUMERO-CHAPITRE"
exit 1
;;

esac
exit 0
