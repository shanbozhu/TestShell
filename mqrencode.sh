#!/bin/bash
# usage:
# ./mqrencode.sh "args"

set -e  # 遇到错误时立即退出脚本
set -o pipefail  # 管道命令中任意一个失败都会让脚本失败

# 检查是否安装 qrencode
cmd="qrencode"
if ! command -v "$cmd" &>/dev/null; then
  printf "qrencode 未安装，正在安装...\n" >&2
  if ! brew install qrencode; then
    printf "qrencode 安装失败，请重试。\n" >&2
    exit 1
  fi
  printf "qrencode 安装成功。\n"
fi

# 设置时间戳、保存路径和文件名
time=$(date "+%Y-%m-%d_%H-%M-%S")
prefix="$HOME/Desktop/mqrencode"
suffix=".png"
file_path="${prefix}/${time}${suffix}"

# 检查目录是否存在，不存在则创建
if [[ ! -d "$prefix" ]]; then
  printf "目录 %s 不存在，正在创建...\n" "$prefix" >&2
  if ! mkdir -p "$prefix"; then
    printf "目录 %s 创建失败，请重试。\n" "$prefix" >&2
    exit 1
  fi
  printf "目录 %s 创建成功。\n" "$prefix"
fi

# 如果$1不为空，直接使用$1，否则从标准输入文件读取
if [[ -n "$1" ]]; then
    input="$1"
else
    #input=$(cat) # 从标准输入文件读取全部数据到input变量。
    read -r input # 从标准输入文件读取一行数据到input变量。
fi

# 确保传入参数不为空
if [[ -z "$input" ]]; then
  printf "错误：未传入要生成二维码的内容。\n" >&2
  exit 1
fi

# 生成二维码
if qrencode -o "$file_path" -s 10 -m 1 "$input"; then
  printf "二维码生成成功，已自动打开保存的目录：%s\n" "$file_path"
else
  printf "二维码生成失败，请检查输入内容。\n" >&2
  exit 1
fi

# 打开目录
if ! open "$prefix"; then
  printf "无法打开目录 %s，请手动检查。\n" "$prefix" >&2
fi
