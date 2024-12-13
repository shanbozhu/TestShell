# TestShell

shell有多种，常用shell有`bash`、`sh`、`zsh`等。

可执行文件包含`二进制文件`和`文本文件`（特指文本文件中的`脚本文件`）。

### 1. 执行脚本

`./x.sh`

`bash x.sh`

### 2. 执行脚本并打印执行过程

1. 打印全部执行过程

`bash -x x.sh`

也可以修改`debug提示符`后在执行上面的语句：

`export PS4='+\e[01;32m[${BASH_SOURCE}:${FUNCNAME[0]}:${LINENO}]\e[00m '`

2. 打印部分执行过程

shell脚本中加`set -x`开头和`set +x`结尾，然后执行`bash x.sh`，中间部分的代码打印执行过程

### 3. 检查语法

`bash -n x.sh`

### 4. 调试脚本

`bashdb x.sh`

或使用IDE：

收费：`IDEA + BashSupport Pro`

免费：`VSCode + Bash Debug`

参考文档：https://yebd1h.smartapps.cn/pages/blog/index?blogId=127956803&_swebfr=1&_swebFromHost=bdlite

### 5. 在子shell中执行给定的字符串作为的命令

`bash -c "echo 'Hello'"`

`bash -c "$(curl -fsSL http://x.sh)"`

`-c`后面的字符串通常来自网络下载

### 6. set命令常用选项

在shell脚本中，set命令用于改变shell环境的行为。

`set -e`：当命令失败时（返回非零状态码），脚本将立即退出。这有助于防止脚本在出现错误时继续运行，导致意外的后果。

`set -u`：当使用未定义的变量时，脚本将立即退出。这样可以避免由于拼写错误或未初始化的变量导致的错误。

`set -o pipefail`：确保整个管道（由 | 分隔的命令序列）的返回值是最后一个失败命令的返回值，而不是仅仅最后一个命令的返回值。这样可以更可靠地检测管道中的错误。

将这些选项结合起来使用，可以显著提高脚本的可靠性和可维护性。

推荐在写shell脚本时，开头加上`set -euo pipefail`。这将确保脚本在遇到错误、使用未定义变量或管道失败时立即退出。

```
#!/bin/bash

set -e
set -u
set -o pipefail
或者
set -euo pipefail

# Your script here
```
