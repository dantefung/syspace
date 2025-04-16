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
