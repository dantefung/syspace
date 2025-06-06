#!/bin/bash

# 要使用 sed 命令删除文件中的所有空行并将结果写回原文件，可以使用 -i 选项。以下是具体步骤和命令：
# sed -i '/^$/d' config.ini

# 1. 使用 sed 命令删除文件中的空行。
# 2. 使用 -i 选项，表示在 sed 命令执行过程中，直接修改文件。
# 3. 使用 /^$/d 表示删除匹配行，其中 ^$ 表示行首和行尾，表示空行。
# 4. 将 sed 命令的结果写回原文件。

# /^$/d 的详细解释
# /.../：这是 sed 命令中的地址范围，用于指定要处理的行。在这个例子中，/.../ 包含了一个正则表达式。
# ^$：这是一个正则表达式，用于匹配空行。
# ^：表示行的开始。
# $：表示行的结束。
# 因此，^$ 匹配的是一个没有任何字符的行，即空行。
# d：这是一个 sed 命令，表示删除匹配的行。

# 不修改文件
#   sed '/^$/d' 文件路径 > 临时文件路径 && mv 临时文件路径 文件路径
sed '/^$/d' config.ini
