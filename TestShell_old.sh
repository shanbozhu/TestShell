#!/bin/bash

# 使用declare -i
declare -i m n ret
m=10
n=30
ret=$m+$n # 此种写法，+左右两边不能有空格
echo "$ret"

# 使用let
i=2
let i+=8 # 此种写法，+=左右两边不能加空格
echo "$i"

# 使用expr命令
i=3
echo "`expr 4 + $i`"
j=`expr 5 + 6`
echo "$j"

# test等价于[  ]，此时[  ]左右两边各含有一个空格
# test比(())更强大。(())只能比较整型，test可以比较整型、字符串、文件（实际也是字符串，因为传入的是文件路径，是字符串）。test命令中使用的变量建议加双引号
# 字符串比较是从左至右逐个比较字符对应的ASCII码
age=18
if test "$age" -gt 0 && test "$age" -le 17; then
    echo "你还未成年哦!"
else
    echo "你已经是成人了!"
fi

filename="/dev/null"
if test -w "$filename"; then
    echo "文件存在且有可写权限!"
else
    echo "文件不存在!"
fi

str1=hello
str2=world
if test -n "$str1" && test -n "$str2"; then
    echo "str1和str2都不为空!"
else
    echo "str1和str2至少有一个为空!"
fi

if test -n "$str1" -a -n "$str2"; then
    echo "str1和str2都不为空!"
else
    echo "str1和str2至少有一个为空!"
fi

if [ -n "$str1" -a -n "$str2" ]; then
    echo "str1和str2都不为空!"
else
    echo "str1和str2至少有一个为空!"
fi

if [ "$str1" \> "$str2" ]; then
    echo "str1大于str2!"
else
    echo "str1小于等于str2!"
fi

if [[ "$str1" == "$str2" ]]; then
    echo "str1 == str2!"
else
    echo "str1 != str2!"
fi

if [ "$str1" == "$str2" ]; then
    echo "str1 == str2!"
else
    echo "str1 != str2!"
fi

if [[ -n $str1 ]] && [[ -n $str2 ]]; then
    echo "str1和str2都不为空!"
else
    echo "str1和str2至少有一个为空!"
fi