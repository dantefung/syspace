
#!/bin/bash

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
echo "1. feature-1"
echo "2. feature-2"
echo "3. feature-3"

# 读取用户输入的选项
read -p "请选择： " branchOption

# 根据用户选择的选项进行相应的分支合并操作
case $branchOption in
  1)
    updateCode && git merge feature-1
    ;;
  2)
    git merge feature-2
    ;;
  3)
    git merge feature-3
    ;;
  *)
    echo "无效的选项"
    exit 1
    ;;
esac

# 合并成功后推送到 origin
git push origin develop
