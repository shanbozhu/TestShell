#!/bin/bash
# usage:
# ./mqrencode.sh "字符串"

# 命令是否安装
cmd="qrencode"
if ! which $cmd &> /dev/null; then
  echo "qrencode 未安装，正在安装..."
  brew install qrencode
  if [ $? -eq 0 ]; then
    echo "qrencode 安装成功。"
  else
    echo "qrencode 安装失败，请重试。"
    exit 1
  fi
fi

time=$(date "+%Y-%m-%d_%H-%M-%S")
prefix="$HOME/Desktop/mqrencode"
suffix=".png"
file_path="${prefix}/${time}${suffix}"

# 目录是否存在
if [ ! -d "$prefix" ]; then
  echo "目录 $prefix 不存在，正在创建..."
  mkdir -p "$prefix"
  if [ $? -eq 0 ]; then
    echo "目录 $prefix 创建成功。"
  else
    echo "目录 $prefix 创建失败，请重试。"
    exit 1
  fi
fi

# 生成二维码
qrencode -o $file_path -s 10 -m 1 $1
if [ $? -eq 0 ]; then
  echo "二维码生成成功，已自动打开保存的目录。"
else
  echo "二维码生成失败，请重试。"
  exit 1
fi
open ${prefix}