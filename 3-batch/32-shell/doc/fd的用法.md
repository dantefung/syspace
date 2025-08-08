fd 是一个现代、高效、易用的命令行文件查找工具，很多人用它替代传统的 `find` 命令。它默认支持颜色高亮，语法简单，速度快。

下面给你整理一些 `fd` 的最佳实践和常用技巧，帮助你更高效地用它查找文件：

---

## 1. 基础用法

```bash
fd pattern
```

* 在当前目录递归查找所有文件名匹配 `pattern` 的文件。
* 支持正则表达式，也支持简单的通配。

---

## 2. 指定搜索目录

```bash
fd pattern /path/to/dir
```

* 指定目录搜索，不写则默认当前目录。

---

## 3. 过滤目录和文件

* 排除某些目录：

```bash
fd pattern --exclude node_modules
```

* 多个排除：

```bash
fd pattern --exclude node_modules --exclude dist
```

---

## 4. 只搜索文件或目录

* 只查文件：

```bash
fd pattern --type f
```

* 只查目录：

```bash
fd pattern --type d
```

---

## 5. 忽略大小写搜索

```bash
fd -i pattern
```

---

## 6. 按文件扩展名查找

```bash
fd -e js
```

* 支持多个扩展：

```bash
fd -e js -e ts
```

---

## 7. 结合 `xargs` 做批量处理

查找所有 `.log` 文件并删除：

```bash
fd -e log -x rm {}
```

或更常见的

```bash
fd -e log -X rm
```

`-x` 表示对每个结果执行命令，`{}` 是结果占位符。
`-X` 表示对所有结果一起执行一次命令。

---

## 8. 结合 `--exec` (和 `-x` 类似)

```bash
fd pattern --exec command {}
```

---

## 9. 只查隐藏文件

默认不查隐藏文件，使用：

```bash
fd -H pattern
```

---

## 10. 查找最近修改的文件（配合其他命令）

`fd` 不支持时间过滤，配合 `find` 或其他工具：

```bash
fd pattern -x stat -c '%Y %n' | sort -nr | head
```

---

## 11. 使用颜色输出和格式化

默认带颜色，方便阅读。

---

## 12. 结合 `fzf` 交互式选择

```bash
fd pattern | fzf
```

---

## 13. 使用配置文件

可以放在 `~/.config/fd/config`，提前设置默认参数。

---

## 14. 常用示例总结

* 查找所有 `.py` 文件，排除 `tests` 目录：

```bash
fd -e py --exclude tests
```

* 查找所有包含 `TODO` 的文件：

```bash
fd TODO -x grep TODO {}
```

* 查找隐藏文件：

```bash
fd -H .bashrc
```

* 查找目录：

```bash
fd --type d node_modules
```

---

## 总结

* `fd` 简洁替代 `find`，速度快，默认排除隐藏和 `.git` 目录。
* 用 `--exclude` 灵活排除目录。
* 用 `-e` 按扩展查找。
* 用 `-x` 或 `--exec` 做批处理。
* 支持正则和忽略大小写。
* 结合 `fzf` 和其他命令，扩展能力强。

---

```

# 基础查找：查找当前目录所有匹配的文件
alias f='fd'

# 查找指定扩展名文件，比如 js、ts
alias fjs='fd -e js -e ts'

# 查找目录
alias fd_d='fd --type d'

# 查找文件
alias fd_f='fd --type f'

# 查找隐藏文件和目录
alias fd_h='fd -H'

# 排除 node_modules 和 dist 目录查找
alias fd_nd='fd --exclude node_modules --exclude dist'

# 忽略大小写查找
alias f_i='fd -i'

# 查找某个模式并进入交互式选择 (结合 fzf)
alias ff='fd | fzf'

# 查找包含某字符串的文件（grep + fd）
function fg() {
  if [[ -z "$1" ]]; then
    echo "Usage: fg <pattern>"
    return 1
  fi
  fd -x grep -I --color=always -n "$1" {}
}

# 查找某扩展名文件并执行命令
# 用法: fxjs rm
function fxjs() {
  if [[ -z "$1" ]]; then
    echo "Usage: fxjs <command>"
    return 1
  fi
  fd -e js -e ts -x "$1" {}
}

# 查找所有日志文件并清空内容（示例）
alias fdlogclear='fd -e log -x truncate -s 0 {}'

# 查找最近修改的文件（结合 stat、sort）
alias fd_recent='fd --type f -x stat --format="%Y %n" {} | sort -nr | cut -d" " -f2- | head -20'

# 查找并删除所有 .DS_Store 文件（macOS）
alias fd_del_ds='fd -e DS_Store -x rm -f {}'

# 查找含有 TODO 的文件并显示行号
function ftodo() {
  fd -x grep -n TODO {}
}

# 查找所有大于 1MB 的文件（用 find）
alias fd_big='find . -type f -size +1M -exec ls -lh {} +'

# 递归查找某个文件并跳转到文件所在目录
function cdto() {
  local file
  file=$(fd "$1" | head -1)
  if [[ -n "$file" ]]; then
    cd "$(dirname "$file")" || return
  else
    echo "File not found."
  fi
}


```
----


当然！我们来逐部分解析这条命令：

```bash
fd -x grep -n TODO {}
```

---

### 🔧 命令分解：

| 部分             | 含义                              |
| -------------- | ------------------------------- |
| `fd`           | 使用 `fd` 工具来查找文件（比 `find` 更快更简洁） |
| `-x`           | 指定对每一个查找到的结果都执行一次后面的命令（逐个执行）    |
| `grep -n TODO` | 在每个文件中查找包含 `TODO` 字符串的行，并显示行号   |
| `{}`           | 占位符，表示每个 `fd` 找到的文件路径会替换到这个位置上  |

---

### 🧠 举例说明：

假设你的项目目录中有以下文件：

```
src/app.js         （包含一行注释：// TODO: implement login）
README.md          （没有 TODO）
config/settings.js （包含一行注释：// TODO: refactor）
```

运行：

```bash
fd -x grep -n TODO {}
```

等价于执行：

```bash
grep -n TODO src/app.js
grep -n TODO config/settings.js
```

输出会类似：

```
src/app.js:12:// TODO: implement login
config/settings.js:3:// TODO: refactor
```

---

### ✅ 总结：用途场景

这条命令的用途是：

> 🔍 **递归搜索所有文件中包含 `TODO` 的行，带行号显示**

很适合开发时快速定位代码中的 TODO / FIXME / HACK 等标记任务项。

---

### 💡 衍生用法建议：

1. **忽略某些目录：**

```bash
fd -x grep -n TODO {} --exclude node_modules --exclude dist
```

2. **支持颜色高亮（手动加 `--color=always`）：**

```bash
fd -x grep --color=always -n TODO {}
```

3. **查找多个关键词（正则匹配）：**

```bash
fd -x grep -nE "TODO|FIXME" {}
```

---


