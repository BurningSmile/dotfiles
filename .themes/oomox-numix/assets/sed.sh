#!/bin/sh
sed -i \
         -e 's/#4d4d4d/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#4d4d4d/rgb(50%,0%,0%)/g' \
     -e 's/#f0544c/rgb(0%,50%,0%)/g' \
     -e 's/#4d4d4d/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	*.svg
