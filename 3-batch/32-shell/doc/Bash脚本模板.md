好的！下面是一个**带参数验证、帮助提示、默认值处理**的 Bash 脚本模板，适合入门或封装小工具使用：

---

### ✅ 通用 Bash 脚本模板（带参数校验 + usage + 默认值）：

```bash
#!/bin/bash

# 打印用法
usage() {
  echo "Usage: $0 [-f <file>] [-m <mode>] [-h]"
  echo ""
  echo "Options:"
  echo "  -f <file>   指定要处理的文件（必选）"
  echo "  -m <mode>   模式，可选：fast、safe，默认：safe"
  echo "  -h          显示帮助信息"
  exit 1
}

# 默认值
mode="safe"
file=""

# 解析参数
while getopts ":f:m:h" opt; do
  case ${opt} in
    f )
      file="$OPTARG"
      ;;
    m )
      mode="$OPTARG"
      ;;
    h )
      usage
      ;;
    \? )
      echo "无效选项: -$OPTARG" >&2
      usage
      ;;
    : )
      echo "选项 -$OPTARG 需要参数" >&2
      usage
      ;;
  esac
done

# 参数验证
if [ -z "$file" ]; then
  echo "错误：必须指定 -f 参数（文件）"
  usage
fi

# 示例处理逻辑
echo "开始处理文件: $file"
echo "使用模式: $mode"

# TODO: 这里写你自己的业务逻辑
```

---

### ✅ 使用方式：

```bash
# 正确用法
./script.sh -f data.txt -m fast

# 演示输出
开始处理文件: data.txt
使用模式: fast
```

```bash
# 错误用法
./script.sh
# 输出
错误：必须指定 -f 参数（文件）
Usage: ./script.sh [-f <file>] [-m <mode>] [-h]
...
```

---

这个模板支持：

- 使用 `-f` 指定文件（必填）
- 使用 `-m` 指定模式（默认是 `safe`）
- `-h` 打印帮助
- 所有参数都使用标准的 `getopts` 风格

如果你有具体的脚本目标或执行流程，我可以帮你把上面的模板进一步裁剪和定制。需要的话直接说哈～