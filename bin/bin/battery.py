#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
from operator import methodcaller

battery = subprocess.getoutput("acpi").split("\n")
battery_items = list(map(methodcaller("split", " "), battery))

res = "{} {}".format(battery_items[0][3], battery_items[1][3])
res = res.replace('%', '')
res = res.replace(',', '')

print(res)
