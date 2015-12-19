#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess, time
from operator import methodcaller

minimum = 15
pause   = 0.1
colors  = ["520d0d", "590b0b", "630c0c", "630c0c", "590b0b", "520d0d"]

capacity_cmd = "acpi -b | cut -d, -f2 | cut -d' ' -f2 | cut -d% -f1"
charging_cmd = "acpi -b | cut -d' ' -f3 | cut -d, -f1"
border_cmd = "chwb -c {} {}"

def exec(command):
    return subprocess.getoutput(command)

while True:
    capacity = map(int, exec(capacity_cmd).split("\n"))
    charging = exec(charging_cmd).split("\n")

    while sum(capacity) < minimum and "Charging" not in charging:
        window = exec("pfw")

        for c in colors:
            exec(border_cmd.format(c, window))
            time.sleep(0.1)

        capacity = map(int, exec(capacity_cmd).split("\n"))
        charging = exec(charging_cmd).split("\n")

    time.sleep(5)
