<< comment

while getopts ":hp:" opt; do:
getopts 是一个内置命令，用于解析命令行选项。
":hp:" 是选项字符串：
: 表示 getopts 应该静默错误而不是打印错误信息。
h 表示 -h 是一个短选项，不需要参数。
p: 表示 -p 是一个短选项，需要参数。
opt 是一个变量，用于存储当前解析的选项字符。

comment

# 通常使用 getopts 内置命令来解析短选项（如 -h）
while getopts ":hp:" opt; do
  #   匹配 -h 选项。
  case ${opt} in
    h )
      echo "Help option is triggered"
      ;;
    p )
      echo "Parameter option is triggered with value: $OPTARG"
      ;;
    # 匹配无效选项
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
    # 匹配缺少参数的选项
    : )
      echo "Invalid Option: -$OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done
# OPTIND 是一个特殊变量，表示下一个要处理的参数的位置。
# shift $((OPTIND -1)) 移除已经处理过的选项及其参数，使得 $1, $2, ... 变量指向未处理的参数。
shift $((OPTIND -1))
