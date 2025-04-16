

没问题！咱们来一套 Bash 字符串处理技巧的 **🧠速查表 + 🧪测试样例 + 🧩小练习**，保证你看到一眼就懂，用起来就顺。

---

## 📘 Bash 字符串处理速查表

| 表达式              | 含义                                | 示例输入                  | 示例输出         |
|---------------------|-------------------------------------|---------------------------|------------------|
| `${var#pattern}`     | 删除**最短匹配的前缀**              | `"abc=123"`               | `123`            |
| `${var##pattern}`    | 删除**最长匹配的前缀**              | `"abc=123=456"`           | `456`            |
| `${var%pattern}`     | 删除**最短匹配的后缀**              | `"abc=123"`               | `abc`            |
| `${var%%pattern}`    | 删除**最长匹配的后缀**              | `"abc=123=456"`           | `abc`            |
| `${#var}`            | 获取变量长度（字符数）              | `"hello"`                 | `5`              |
| `${var:pos}`         | 从 `pos` 开始截取到末尾             | `"abcdef"`                | `"cdef"`（pos=2）|
| `${var:pos:len}`     | 从 `pos` 开始截取 `len` 个字符       | `"abcdef"`                | `"cd"`（2,2）    |
| `${var/pat/repl}`    | 替换第一个匹配                      | `"abcabc" → a → x`        | `"xbcabc"`       |
| `${var//pat/repl}`   | 替换所有匹配                        | `"abcabc" → a → x`        | `"xbcxbc"`       |

---

## 🧪 测试样例脚本

保存成 `test-string-tricks.sh` 然后执行：

```bash
#!/usr/bin/env bash

echo "=== 字符串替换 & 删除 Demo ==="

str="user=john.doe@example.com"

echo "原始字符串: $str"

echo "取 key（%%=*）: ${str%%=*}"
echo "取 value（#*=）: ${str#*=}"

echo "删除最短后缀（%.*）: ${str%.*}"
echo "删除最长后缀（%%.*）: ${str%%.*}"

echo "删除最短前缀（#*@）: ${str#*@}"
echo "删除最长前缀（##*@）: ${str##*@}"

echo "替换第一个 . 为 _: ${str/. /_}"
echo "替换所有 . 为 _: ${str//./_}"

echo "取 5 个字符长度: ${str:0:5}"
echo "总长度: ${#str}"
```

---

## 🧩 小练习：你来填空题！

```bash
email="foo.bar@domain.com"
```

### 问题 1️⃣：提取用户名（`foo.bar`）：

```bash
username=_________
```

> ✅ 答案：`${email%@*}`

---

### 问题 2️⃣：提取域名部分（`domain.com`）：

```bash
domain=_________
```

> ✅ 答案：`${email#*@}`

---

### 问题 3️⃣：把所有`.`换成 `_`：

```bash
safe_email=_________
```

> ✅ 答案：`${email//./_}`

---

### 问题 4️⃣：如果 email 是 `"a.b.c@xx.yy.zz"`，提取最外层域（`zz`）：

```bash
tld=_________
```

> ✅ 答案：`${email##*.}`

---

想不想我也给你写一个带 **测试断言** 的自动测试脚本，能帮你验证这些表达式在实际脚本中是否工作？还是你想来几个更复杂的练习，比如路径处理、带文件名的拆解？😎

太好了！我们来做一个 **带测试断言的自动化测试脚本**，通过断言检查每个表达式的输出是否符合预期。这样你可以直接运行脚本进行验证，确保这些字符串处理技巧的正确性。

---

## 🛠️ 测试脚本：`test-string-tricks-with-asserts.sh`

这个脚本会执行一系列测试，验证字符串处理的功能是否正常：

```bash
#!/usr/bin/env bash

# 测试断言函数
assert_equal() {
  if [[ "$1" != "$2" ]]; then
    echo "❌ 断言失败: 预期 '$2'，但得到 '$1'"
    exit 1
  else
    echo "✅ 断言通过"
  fi
}

# 原始字符串
email="foo.bar@domain.com"
path="/home/user/project/file.txt"

echo "=== 字符串处理自动化测试 ==="

# 1. 提取用户名（key）
expected_username="foo.bar"
actual_username="${email%@*}"
assert_equal "$actual_username" "$expected_username"

# 2. 提取域名部分（value）
expected_domain="domain.com"
actual_domain="${email#*@}"
assert_equal "$actual_domain" "$expected_domain"

# 3. 删除最短后缀（删除文件扩展名）
expected_path_without_ext="/home/user/project/file"
actual_path_without_ext="${path%.*}"
assert_equal "$actual_path_without_ext" "$expected_path_without_ext"

# 4. 删除最长后缀（删除文件扩展名）
expected_path_without_ext_longest="/home/user/project"
actual_path_without_ext_longest="${path%%.*}"
assert_equal "$actual_path_without_ext_longest" "$expected_path_without_ext_longest"

# 5. 替换第一个点（.）为下划线（_）
expected_safe_email="foo_bar@domain.com"
actual_safe_email="${email/. /_}"
assert_equal "$actual_safe_email" "$expected_safe_email"

# 6. 替换所有点（.）为下划线（_）
expected_safe_email_all="foo_bar@domain_com"
actual_safe_email_all="${email//./_}"
assert_equal "$actual_safe_email_all" "$expected_safe_email_all"

# 7. 提取文件名（去掉路径）
expected_filename="file.txt"
actual_filename="${path##*/}"
assert_equal "$actual_filename" "$expected_filename"

# 8. 提取扩展名（文件后缀）
expected_extension="txt"
actual_extension="${path##*.}"
assert_equal "$actual_extension" "$expected_extension"

# 9. 获取字符串长度
expected_length="23"
actual_length="${#email}"
assert_equal "$actual_length" "$expected_length"

echo "=== 所有测试通过 ==="
```

---

## 🧑‍💻 如何使用？

1. 将这个脚本保存为 `test-string-tricks-with-asserts.sh`。
2. 通过以下命令赋予执行权限：

   ```bash
   chmod +x test-string-tricks-with-asserts.sh
   ```

3. 运行脚本：

   ```bash
   ./test-string-tricks-with-asserts.sh
   ```

---

## ✅ 输出说明

- 每个 **断言** 检查预期结果与实际输出是否一致。
- 如果有断言失败，脚本会退出，并输出失败信息。
- 如果所有测试都通过，输出 **"所有测试通过"**。

---

### 🧩 自定义练习：

你可以修改字符串（如 `email` 或 `path`）来尝试不同的场景，或者增加新的测试用例来检验更多的字符串处理。

---

如果你想要更复杂的功能，比如递归遍历文件路径、处理多个文件扩展名、或者支持更多的 Bash 字符串操作（如替换中间部分），我可以进一步扩展这个脚本。随时告诉我你需要的功能 😎


---

## ✅ `IFS=`：**内部字段分隔符**

```bash
IFS=$'\n'
```

### 🧠 什么是 IFS？

- `IFS`（Internal Field Separator）是 Bash 在**分词时用的分隔符**。
- 默认情况下，IFS 是空格、Tab、换行，也就是说：
  
  ```bash
  for item in $myString; do ...  # 会按空格分词
  ```

### 🔧 为什么要设置 `IFS=$'\n'`？

- 当我们用 `sort` 等命令处理数组并重新赋值给数组时，需要用换行来区分每一项，而不是默认的空格。
- 例如：
  
  ```bash
  sorted=($(echo "${items[*]}" | sort))
  ```

  - 如果不设置 `IFS=$'\n'`，排序后的结果会因为空格被拆成很多项。
  - 所以先设置 `IFS=$'\n'`，再执行分词赋值。

---

## ✅ `${pair%%=*}`：提取 **key**

### 🔍 语法含义

```bash
${var%%pattern}
```

- 是 **最贪婪的后缀删除**：删除匹配 pattern 的最右边部分

在上下文中：

```bash
key="${pair%%=*}"
```

- `pair` 例如是 `"dev=development"`
- `%%=*` 表示删除最后一个等号及其右边所有内容
- 所以返回的就是 `dev`（等号左边的 key）

---

## ✅ `${pair#*=}`：提取 **value**

### 🔍 语法含义

```bash
${var#pattern}
```

- 是 **最不贪婪的前缀删除**：删除从左边起首次匹配 pattern 的部分

在上下文中：

```bash
val="${pair#*=}"
```

- 同样地，`pair="dev=development"`
- `#*=` 表示删除最左边的第一个等号及其左边所有内容
- 所以留下的就是 `development`（等号右边的 value）

---

## 🧠 举个例子

```bash
pair="main=production"

key="${pair%%=*}"    # -> main
val="${pair#*=}"     # -> production
```

---

## 🔁 `%` vs `#` 总结口诀

| 表达式      | 方向       | 贪婪性 | 含义                   |
|-------------|------------|--------|------------------------|
| `${var#pat}`  | 左 → 右 | 非贪婪 | 删除最左边最短匹配     |
| `${var##pat}` | 左 → 右 | 贪婪   | 删除最左边最长匹配     |
| `${var%pat}`  | 右 ← 左 | 非贪婪 | 删除最右边最短匹配     |
| `${var%%pat}` | 右 ← 左 | 贪婪   | 删除最右边最长匹配     |

---

需要我再总结成 Bash 字符串处理速查表，或者来一套测试样例演示这些字符串处理技巧？也可以来个小练习帮你巩固理解 😎