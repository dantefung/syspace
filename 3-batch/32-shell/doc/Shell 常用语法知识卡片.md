好的，我将为你生成一份【Shell 常用语法知识卡片】（软萌风，适合记忆&查阅），内容涵盖你常遇到的 `$?`、`$0`、流程控制、判断、函数等内容，适合作为学习速查用。

---

## 🐚 Shell 常用语法知识卡片

> 🌸 每天背一点，脚本不再怕！

---

### 📦 基础变量和参数

| 表达式        | 含义               |
| ---------- | ---------------- |
| `$0`       | 当前脚本名            |
| `$1`\~`$9` | 第 1～9 个传入参数      |
| `$@`       | 所有参数，逐个独立处理      |
| `$*`       | 所有参数，作为一个整体字符串   |
| `$#`       | 参数总个数            |
| `$?`       | 上一个命令的退出状态（0=成功） |
| `$$`       | 当前脚本的进程 ID       |
| `$!`       | 最近的后台进程的进程 ID    |

---

### 🍱 变量操作

```bash
name="hello"
echo $name
```

* 引用带空格的变量必须加双引号：`"$name"`
* 判断变量是否为空：`[ -z "$var" ]`

---

### 🔁 条件判断

```bash
if [ "$a" = "$b" ]; then
  echo "相等"
fi
```

| 表达式               | 含义             |
| ----------------- | -------------- |
| `-z "$x"`         | 空字符串           |
| `-n "$x"`         | 非空字符串          |
| `-f file`         | 是否为普通文件        |
| `-d dir`          | 是否为目录          |
| `"$a" = "$b"`     | 字符串相等          |
| `"$a" != "$b"`    | 字符串不等          |
| `-eq / -gt / -lt` | 数值等于 / 大于 / 小于 |

---

### 🎢 流程控制

#### ✅ if 判断

```bash
if [ condition ]; then
  ...
elif [ condition ]; then
  ...
else
  ...
fi
```

#### 🔁 for 循环

```bash
for file in *.txt; do
  echo "$file"
done
```

#### 🌀 while 循环

```bash
while read line; do
  echo "$line"
done < file.txt
```

---

### 🧩 函数定义

```bash
my_func() {
  echo "Hello $1"
}
my_func World
```

---

### 📤 输入输出与管道

| 表达式    | 含义        |                |
| ------ | --------- | -------------- |
| `>`    | 输出重定向，覆盖  |                |
| `>>`   | 输出重定向，追加  |                |
| `<`    | 输入重定向     |                |
| `2>&1` | 错误输出到标准输出 |                |
| \`     | \`        | 管道，将输出传递给下一个命令 |

---

### 🛠 常用命令工具组合

```bash
cat file.txt | grep "hello" | awk '{print $1}' | sort | uniq
```

* `awk`：文本处理
* `sed`：行替换、插入、删除
* `xargs`：参数批量传递
* `jq`：处理 JSON
* `basename`, `dirname`: 获取路径信息

---

### 🧪 调试技巧

```bash
set -e   # 出错立即退出
set -x   # 打印每条命令执行过程（调试模式）
```

---

### 🎯 参数解析模板（高级）

```bash
while getopts "u:p:" opt; do
  case $opt in
    u) user=$OPTARG ;;
    p) pass=$OPTARG ;;
    *) echo "用法: $0 -u 用户 -p 密码" ;;
  esac
done
```

---

### 🎀 bash 脚本头推荐写法

```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
```

---

## 🧸 小贴士（软萌记忆法）

* `$?`：像问号一样，**你还好吗？（上个命令成功了吗）**
* `$@`：像小猫猫一群，**一堆参数，每个都要关心**
* `[[ ... ]]` 比 `[ ... ]` 更安全、推荐使用
* `set -x` 是调试神器，像开了“显眼包”

---

如果你想要将这份卡片：

1. **生成 Markdown 文件**
2. **转成 PDF/HTML 页面**
3. **导入 Obsidian/Notion/语雀知识库**

我可以为你一键生成 zip 包并提供下载。需要我继续生成吗？
