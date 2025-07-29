# sync_daily.sh 脚本 Bash 语法说明

## 目录
1. shebang 与执行权限
2. set 命令
3. 文件与条件判断
4. 变量与命令替换
5. 数组与遍历
6. 参数解析与 case 语句
7. source 命令
8. 字符串处理与 IFS
9. for 循环与 set --
10. if 复合条件与字符串匹配
11. 文件操作与 curl/awk/sed
12. 子 shell 与命令组合
13. 环境变量与命令执行

---

## 1. shebang 与执行权限
```bash
#!/usr/bin/env bash
```
指定脚本用 bash 解释器执行。

## 2. set 命令
```bash
set -e
# set -x
```
`set -e`：遇到错误立即退出脚本。
`set -x`：调试时打印每一行执行的命令。

## 3. 文件与条件判断
```bash
if [ -f .env ]; then ... fi
if [ -f "$mdfile" ]; then ... fi
```
`[ -f FILE ]` 判断文件是否存在且为普通文件。

## 4. 变量与命令替换
```bash
today=$(TZ='Asia/Shanghai' date +%F)
monthstr=$(TZ='Asia/Shanghai' date +%Y-%m)
```
`$(...)` 用于命令替换，将命令输出赋值给变量。

## 5. 数组与遍历
```bash
ARGS=()
for arg in "$@"; do ... done
TARGET_ALIASES=()
for conf in "${PUSH_CONFIGS[@]}"; do ... done
```
`ARRAY=()` 定义数组。
`for var in "${ARRAY[@]}"; do ... done` 遍历数组所有元素。

## 6. 参数解析与 case 语句
```bash
for arg in "$@"; do
  case "$arg" in
    -i|--interactive)
      ...
      ;;
    *)
      ...
      ;;
  esac
done
```
`case ... esac` 用于多分支条件判断。

## 7. source 命令
```bash
source wechat_push.conf
```
加载并执行另一个 shell 文件的内容。

## 8. 字符串处理与 IFS
```bash
IFS=',' read -ra TARGET_ALIASES <<< "$input_aliases"
for i in "${!TARGET_ALIASES[@]}"; do
  TARGET_ALIASES[$i]=$(echo "${TARGET_ALIASES[$i]}" | xargs)
done
```
`IFS` 设置字段分隔符。
`read -ra` 读取并分割字符串到数组。
`xargs` 去除字符串首尾空白。

## 9. for 循环与 set --
```bash
for conf in "${PUSH_CONFIGS[@]}"; do
  set -- $conf
  alias=$1
  mdfile=$2
  ...
done
```
`set -- $conf` 将字符串按空格分割，依次赋值给 $1, $2 ...

## 10. if 复合条件与字符串匹配
```bash
if [ "${#TARGET_ALIASES[@]}" -eq 0 ] || [[ " ${TARGET_ALIASES[*]} " == *" $alias "* ]]; then
```
- `${#ARRAY[@]}` 获取数组长度。
- `[[ ... == *pattern* ]]` 字符串通配符匹配。
- `${ARRAY[*]}` 数组拼接为字符串。

## 11. 文件操作与 curl/awk/sed
```bash
curl -fSL -o "$mdfile" "$url"
awk '/pattern/{exit} {print}' "$mdfile" > tmp && mv tmp "$mdfile"
sed -i 's#pattern#replace#g' "$mdfile"
```
- `curl` 下载文件。
- `awk` 文本处理，按模式截断。
- `sed` 文本替换与删除。

## 12. 子 shell 与命令组合
```bash
PYTHON_BIN="$(which python || which python3 || echo /usr/local/bin/python)"
```
- `$(...)` 命令替换。
- `||` 逻辑或，前面命令失败则执行后面。

## 13. 环境变量与命令执行
```bash
WECHAT_APP_ID="$app_id" WECHAT_APP_SECRET="$app_secret" $PYTHON_BIN sync.py ...
```
- `VAR=VAL command` 临时设置环境变量并执行命令。 