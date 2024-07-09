#!/bin/bash
# usage:
# ./mqrencode.sh "字符串"

time=$(date "+%Y-%m-%d_%H-%M-%S")
prefix="/Users/wsc/Desktop/mqrencode/"
suffix=".png"

qrencode -o "${prefix}${time}${suffix}" -s 10 -m 1 "zhushanbo"
open ${prefix}
echo "hello"