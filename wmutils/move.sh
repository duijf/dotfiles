#!/usr/bin/env sh
wmv $1 $2 $3
# Move the mouse to the window's bottom right corner.
wmp -a $(wattr xy $3)
wmp -r $(wattr wh $3)
