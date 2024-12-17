#!/bin/bash

## 一、变量定义

# 整型
a=123 # 等号两边不能有空格
echo "$a"
readonly d=123 # 只读变量

# 1、setter
a=456
# 2、getter
echo "$a" # $等价于${}，表示取值
echo "${a}"
echo "`ls -l`" # ``等价于$()，执行命令或函数并捕获echo输出
echo "$(ls -l)"

# 浮点型
a=1.23
echo "$a"

# 字符串
a=hello
echo "$a"
a='hello'
echo "$a"
c="hello"
echo "$a"
b='123$a' # 单引号：原样输出
c="123$a" # 双引号：占位符会被替换
echo "$b" # echo输出变量建议加双引号，否则，容易出现格式混乱
echo "$c"

# 数组
a=(29 100 13 8 91 44)
echo "${a[@]}" # 独立输出所有元素

a=(20 56 "hello world")
echo "${a[*]}" # 整体输出所有元素

for element in "${a[@]}"; do
  echo "独立输出所有元素：$element" # 独立输出所有元素
done
for element in "${a[*]}"; do
  echo "整体输出所有元素：$element" # 整体输出所有元素
done

arr1=(29 100 13 8 91 44)
arr2=(20 56 "hello world")
echo "${arr1[1]}" # 输出索引为1的元素
echo "${arr2[*]}" # 整体输出所有元素
arr1[10]=66
echo "${arr1[@]}" # 独立输出所有元素
echo "${arr2[2]}" # 输出索引为2的元素
echo "${#arr1[@]}" # 输出元素个数
echo "${#arr2[*]}" # 输出元素个数
arr3=(${arr1[*]} ${arr2[*]}) # 数组拼接
echo "${arr3[*]}"
unset arr3[1] # 删除数组元素
echo "${arr3[1]}"

# 字典
# 无

## 二、特殊变量

# 1、脚本或函数的参数：$1、$2、...、${10}、${11}、...、${n}
# 2、脚本文件名：$0
# 3、脚本或函数的参数个数：$#
# 4、脚本或函数的所有参数：$*或$@。$@会将每个参数保持为独立的参数，保留它们的边界，即使单个参数中含有空格。
# 5、上一个命令的退出状态或函数返回值：$?
# 6、当前shell进程ID：$$

## 三、字符串处理

# 1、字符串长度：${#string_name}
str="hello world"
echo "${#str}"

# 2、字符串拼接：${string_name1}${string_name2}
str1=hello
str2=world
str3=${str1}${str2}
echo "----$str3" # ----helloworld
str4="${str1} ${str2}"
echo "----$str4" # ----hello world
str5="${str1}""${str2}"
echo "----$str5" # ----helloworld

# 3、字符串截取
str="hello world"
# 3.1、${string: index: length}或${string: 0-index: length}
echo "${str: 2: 5}" # 从左至右，从左0计数，索引从2开始，长度为5
echo "${str: 2}" # 从左至右，从左0计数，索引从2开始，长度为到末尾
echo "${str: 0-7: 5}" # 从左至右，从右1计数，索引从7开始，长度为5
echo "${str: 0-7}" # 从左至右，从右1计数，索引从7开始，长度为到末尾
# 3.2、${string#*substring}或${string##*substring}
echo "${str#*el}" # 截取最前一个*el右边的所有字符，*是通配符
echo "${str##*l}" # 截取最后一个*l右边的所有字符，*是通配符
# 3.3、${string%substring*}或${string%%substring*}
echo "${str%l*}" # 截取最后一个l*左边的所有字符，*是通配符
echo "${str%%l*}" # 截取最前一个l*左边的所有字符，*是通配符

## 四、数据运算—— (())对整型进行运算。对括号内的变量取值时，$可省略

# 算术运算
echo "$((1 + 1))" # 相当于，echo "${((1 + 1))}"
i=5
((i = i + 5))
j=$((i = i + 5, 4 + 5))
echo "$i"
echo "$j"

# 关系运算（返回bool值）
echo "$((3 < 8))" # 输出1表示真
echo "$?" # 输出0，表示上一个命令执行成功，退出状态为0。上一个命令执行失败，退出状态为非0，一般为1
echo "$((3 > 8))" # 输出0表示假
echo "$?" # 输出0，表示上一个命令执行成功，退出状态为0。上一个命令执行失败，退出状态为非0，一般为1
echo "$((3 == 3))" # 输出1表示真

# 逻辑运算（对bool值进行运算，返回的还是bool值）
echo "$((3 == 3 && 3 < 8 && 3 < 6))" # 输出1表示真
echo "$?" # 输出0，表示上一个命令执行成功，退出状态为0。上一个命令执行失败，退出状态为非0，一般为1

## 五、控制语句

# ---------------- 判断

# (()) 对整型进行关系运算，使用>、<、==等符号。对括号内的变量取值时，$可省略。
# [[]] 对整型和字符串进行关系运算，对整型运算时使用-eq等选项，对字符串运算时使用>、<、==等符号。

# 1、if语句
num1=10
num2=20
if ((num1 > num2)); then
    echo "num1大于num2"
else
    echo "num1小于或等于num2"
fi

# -eq：等于
# -ne：不等于
# -gt：大于（greater than）
# -lt：小于（less than）
# -ge：大于等于（greater than or equal to）
# -le：小于等于（less than or equal to）
if [[ $num1 -gt $num2 ]]; then # [[]] 中的$var不用加双引号
    echo "num1大于num2"
else
    echo "num1小于等于num2"
fi

str1="hel lo"
str2="hel lo"

# -z str 判断字符串是否为空。
# -n str 判断宇符串是否为非空。
if [[ -z $str1 && -z $str2 ]]; then
    echo "str1和str2都为空!"
else
    echo "str1和str2至少有一个不为空!"
fi

if [[ -n $str1 && -n $str2 ]]; then
    echo "str1和str2都不为空!"
else
    echo "str1和str2至少有一个为空!"
fi

# 字符串比较是从左至右逐个比较字符对应的ASCII码
# ASCII：美国信息交换标准代码
if [[ $str1 == $str2 ]]; then
    echo "str1等于str2!"
else
    echo "str1不等于str2!"
fi

if [[ $str1 != $str2 ]]; then
    echo "str1不等于str2!"
else
    echo "str1等于str2!"
fi

if [[ $str1 > $str2 ]]; then
    echo "str1大于str2!"
else
    echo "str1小于等于str2!"
fi

if [[ $str1 < $str2 ]]; then
    echo "str1小于str2!"
else
    echo "str1大于等于str2!"
fi

num1=20
num2=10
str1="hel lo"
str2="ael lo"
if ((num1 > num2)) && [[ $str1 > $str2 ]]; then
    echo "num1大于num2 且 str1大于str2"
else
    echo "num1小于等于num2 或 str1小于等于str2"
fi

# -d filename 判断文件是否存在，并且是否为目录文件。
# -e filename 判断文件是否存在。
# -f filename 判断文件是否存在，井且是否为普通文件。
# -s filename 判断文件是否存在，并且是否为非空。
# -r filename 判断文件是否存在，并且是否拥有读权限。
# -w filename 判断文件是否存在，并且是否拥有写权限。
# -x filename 判断文件是否存在，并且是否拥有执行权限。
filename="/Users/zhushanbo/Desktop/Test/TestShell/TestShell.sh"
if [[ -w $filename ]]
then
    echo "文件存在，并且拥有写权限"
else
    echo "文件不存在，或文件存在但是不拥有写权限"
fi

filename="/Users/zhushanbo/Desktop/Test/TestShell/helloworld.sh"
if [[ ! -f $filename ]]
then
    echo "文件不存在"
else
    echo "文件存在"
fi

# 2、case语句
str=b
case $str in # 这里的str是取值操作，所以需要加$
    a)
        echo "我是a"
        ;; # ;;跳出case语句
    b)
        echo "我是b"
        ;;
    c)
        echo "我是c"
        ;;
    *)
        echo "error"
esac

# ---------------- 循环

# 1、while语句
i=1
sum=0
while ((i <= 100))
do
    ((sum += i))
    ((i++))
done
echo "sum = $sum"

i=1
sum=0
while [[ $i -le 100 ]]
do
    ((sum += i))
    ((i++))
done
echo "sum = $sum"

# 2、for语句
sum=0
for ((i=1; i <= 100; i++))
do
    ((sum += i))
done
echo "sum = $sum"

sum=0
for i in 1 2 3 4 5 # 在for循环内的i相当于是赋值操作，被赋值为1、2、3、4、5等，赋值操作不需要加$
do
    echo "$i"
    ((sum += i))
done
echo "sum = $sum"

for str in "hello" "world" "!"
do
    echo "$str"
done

sum=0
for i in {1..5}
do
    echo "$i"
    ((sum += i))
done
echo "sum = $sum"

for c in {A..z}
do
    printf "%c" $c
done
printf "\n"

for filename in $(ls *.sh)
do
    echo "$filename"
done

for filename in *.sh
do
    echo "$filename"
done

function func() {
    for str in "$@"
    do
        echo "$str"
    done
}
func hello world !

# 3、break还可以后面加数字，跳出多层循环
i=0
while ((++i)); do
    j=0
    while ((++j)); do
        if ((i > 4)); then
            break 2
        fi
        
        if ((j > 4)); then
            break
        fi
        
        printf "%-4d" $((i * j))
    done
    
    printf "\n"
done

# 4、continue还可以后面加数字，继续下次多层循环
for ((i=1; i <= 5; i++)); do
    for ((j=1; j <= 5; j++)); do
        if ((i * j == 12)); then
            printf "world\n"
            continue 2
        fi
        printf "%d * %d = %-4d" $i $j $((i * j))
    done
    
    printf "hello\n"
done

## 六、函数

function getsum() {
    number=55 # 无论写在函数内，还是函数外，都是全局变量

    local add=0
    for n in "$@"
    do
        ((add -= n))
    done
    echo "$add"
    return 0 # 推荐写法
}
getsum 10 20 # -30
echo "$?" # 0
reduce=$(getsum 10 20) # 执行命令或函数并捕获echo输出
echo "$?" # 0
echo "$reduce" # -30
echo "$(getsum 10 20)" # -30
echo "`getsum 10 20`" # -30
echo "$number" # 55

get_file_size() {
    if [[ "$(uname)" == "Darwin" ]] || [[ "$(uname)" == "FreeBSD" ]]; then
        # 脚本或函数的参数：$1、$2、...、${10}、${11}、...、${n}
        stat -f%z "$1"
    else
        stat -c%s "$1"
    fi
}
# 脚本文件名：$0
echo "$0" # /Users/zhushanbo/Desktop/Test/TestShell/TestShell.sh
size=$(get_file_size "$0") # 执行命令或函数并捕获echo输出
echo "File size: $size bytes"

## 七、main函数命令行参数

# 1、select语句
read -rp "请输入a的值:" a # 从键盘读取数据赋值给a，按Ctrl+D组合键结束读取
read -rp "请输入b的值:" b
if ((a == b)); then # ;分号是命令连接符，多个命令写在同一行需要加分号，写在不同行不需要加
    echo "a和b相等!"
else
    echo "a和b不相等!"
fi

echo "what is your favourite OS?"
select name in "Linux" "Windows" "Mac OS" "Android" "iOS"
do
    echo "$name"
    case $name in # select一般与case搭配使用
        "Linux")
            echo "Linux是一个类UNIX操作系统，开源免费，一般运行在服务器和嵌入式设备"
            break # 此break是跳出select语句，并不是跳出case语句，;;跳出case语句
            ;;
        "Windows")
            echo "Windows是微软开发的操作系统，闭源收费，一般运行在个人电脑"
            break
            ;;
        "Mac OS")
            echo "Mac OS是苹果基于UNIX开发的操作系统，闭源收费，一般运行在苹果个人电脑"
            break
            ;;
        "Android")
            echo "Android是谷歌开发的操作系统，开源免费，一般运行在智能手机"
            break
            ;;
        "iOS")
            echo "iOS是苹果开发的操作系统，闭源收费，一般运行在苹果智能手机"
            break
            ;;
        *)
            echo "输入错误，请重新输入"
    esac
done
echo "You have selected $name"
