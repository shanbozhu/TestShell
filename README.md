# TestShell

shell有多种，常用shell有`bash`、`sh`、`zsh`等。
可执行文件包含`二进制文件`和`文本文件`（特指文本文件中的`脚本文件`）。

### 1. 执行脚本

`./x.sh`

`bash x.sh`

### 2. 执行脚本并打印执行过程

1. 全部执行过程

`bash -x x.sh`

也可以修改`debug提示符`后在执行上面的语句：

`export PS4='+\e[01;32m[${BASH_SOURCE}:${FUNCNAME[0]}:${LINENO}]\e[00m '`

2. 部分执行过程

代码中加`set -x`开头和`set +x`结尾，然后执行`./x.sh`或`bash x.sh`，中间部分的代码打印执行过程

### 3. 检查语法

`bash -n x.sh`

### 4. 调试脚本

`bashdb x.sh`

参考文档：https://yebd1h.smartapps.cn/pages/blog/index?blogId=127956803&_swebfr=1&_swebFromHost=bdlite
