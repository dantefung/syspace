
## 示例1

```
if [[ ! $URL =~ ^https?:// ]]; then
    echo "Error: Invalid URL format. URL must start with http:// or https://"
    exit 1
fi
```

**解释说明:**

>检查URL是否不匹配正则表达式 "^https?://"
>其中 ^ 表示字符串开始，https? 表示匹配 http 或 https，:// 表示字面量 ://
>如果不匹配（即URL不是以http://或https://开头），则执行then后面的语句
> =~ 是 Bash 中的正则表达式匹配操作符
>用于判断左侧字符串是否匹配右侧的正则表达式模式
>在这里检查 URL 是否不匹配以 http:// 或 https:// 开头的模式
>https? 中的?是针对s 出现0次或1次的意思吗? 答案：是的，? 是正则表达式中的量词，表示前面的字符 's' 出现 0 次或 1 次。
>所以 'https?' 匹配的是 'http' 或 'https'，即匹配 http 或 https 协议
