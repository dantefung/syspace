#!/bin/bash

# 读取配置文件获取 feature 分支信息
filename="config.ini"
configfile=$(realpath "$filename")

# 定义一个关联数组用于存储 feature 分支信息
declare -A branches

# 从配置文件加载 feature 分支信息
while IFS='=' read -r key value; do
  branches["$key"]=$value
done < "$configfile"

function updateCode(
# 切换到 develop 分支，并拉取最新代码
git checkout develop && git pull origin develop \
# 切换到 master 分支，并拉取最新代码
git checkout master && git pull origin master \
# 切换回 develop 分支
git checkout develop
)

# 提示用户选择分支选项
echo "请选择要合并的分支："

# 打印预设的 feature 分支选项
for key in "${!branches[@]}"; do
  echo "$key. ${branches[$key]}"
done

# 读取用户输入的选项
read -p "请选择： " branchOption

echo "您选择了 ${branches[$branchOption]} "

# 根据用户选择的选项进行相应的分支合并操作
if [[ ${branches[$branchOption]} ]]; then
  selectedBranch=${branches[$branchOption]}
  branch=$(echo "$selectedBranch" | tr -d '\r')
  cmd="git merge $branch"
  echo ">>$cmd"
  updateCode && $cmd
  git push origin develop
else
  echo "无效的选项"
  exit 1
fi
