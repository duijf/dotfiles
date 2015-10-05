#!/usr/bin/env sh
wtp $1 $2 $3 $4 $5
# Move the mouse to the window's bottom right corner.
wmp -a $(wattr xy $5)
wmp -r $(wattr wh $5)
