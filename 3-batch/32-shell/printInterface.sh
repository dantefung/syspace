#!/bin/bash
# 输出表头
#
#@RestController
#public class ModelVehicleManageController {
#
#	@Resource
#	private ModelVehicleManageBizService modelVehicleManageBizService;
#
#	/**
#	 * <p>分页获取标准车型列表</p>
#	 * @param req
#	 * @return
#	 */
#	@PostMapping("/manage/vehicle/model-vehicle/get-page-list")
#	public Result<PageVO<ModelVehicleListDTO>> getPageList(@Validated @RequestBody ModelVehicleListReq req) {
#		return Result.buildSuccess(modelVehicleManageBizService.getPageList(req));
#	}
#}

# 指定Java文件路径
#java_file=""

# ./printInterface.sh "文件路径"
java_file=$1

# 控制台输入  "D:/a.txt" 注意要带上引号
#read -p "请输入文件路径,注意带上双引号:" java_file

<< comment
这段代码是一个Shell脚本的命令，用于从Java文件中提取@PostMapping注解的URL路径。

让我们逐步解释这段代码的不同部分：

$(...)：这是Shell中的命令替换语法，它会执行括号内的命令，并将其输出作为变量的值。

grep -oE '@PostMapping\("([^"]+)"\)' $java_file：这是一个grep命令，用于从$java_file文件中匹配并显示所有符合正则表达式@PostMapping\("([^"]+)"\)的内容。

-o选项表示只显示匹配的部分。
-E选项表示使用扩展的正则表达式。
sed 's/@PostMapping("\(.*\)")/\1/'：这是一个s命令，用于在输出中执行替换操作。

's/@PostMapping("\(.*\)")/\1/'是一个替换操作的正则表达式，它会将匹配的内容替换为捕获组\1的值。
\(.*\)是一个捕获组，匹配@PostMapping("和")之间的任意字符。
\1表示捕获组中的内容。

@PostMapping\("([^"]+)"\)是一个正则表达式，它用于匹配以@PostMapping("开头，以")结尾并且中间包含非引号字符的内容。

@PostMapping\(：匹配@PostMapping("，反斜杠\用于转义括号的特殊含义。
([^"]+)：一个捕获组，用于匹配一个或多个非引号字符。
"：匹配引号字符。

最后，将通过grep命令提取的URL路径存储在变量url中。

请注意，这段代码假设Java文件中的@PostMapping注解使用了双引号包裹URL路径。如果注解中使用了其他类型的引号或没有引号包裹URL，代码可能需要相应修改。

comment

## 解析Java文件，获取所有形如@PostMapping行的中的路径，并存储为url变量
url=$(grep -oE '@PostMapping\("([^"]+)"\)' $java_file | sed 's/@PostMapping("\(.*\)")/\1/')

## 截取形如<p>删除标准车型</p>中<p>内的注释内容，并存储为desc变量
desc=$(grep -oE '<p>([^<]+)</p>' $java_file | sed 's/<p>\(.*\)<\/p>/\1/')

# 声明一个名为 arr 的数组
arr=("svc-cn" "svc-hk" "svc-manage")

# 打印数组的内容，让用户选择
echo "请选择一个服务名："
for i in "${!arr[@]}"
do
    echo "$i. ${arr[$i]}"
done

# 获取用户的选择
read -p "请输入选项序号: " choice

# 验证用户的输入是否是一个有效的选项序号
re='^[0-9]+$'
if [[ $choice =~ $re ]] && [[ $choice -ge 0 ]] && [[ $choice -lt ${#arr[@]} ]]
then
    selected="${arr[$choice]}"
    echo "您选择了 $selected"
else
    echo "无效的选项序号"
fi



## 查看变量类型
#declare -p url
#declare -p desc

url_ary=(${url//,/ })
#declare -p url_ary

desc_ary=(${desc//,/ })
#declare -p desc_ary


 #当前时间 对应的秒时间戳
current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
currentTimeStamp=$(((timeStamp*1000+10#`date "+%N"`/1000000)/1000)) #将current转换为时间戳，精确到秒
echo $currentTimeStamp


# 打印输出格式
echo "|类型 | 节点名称 | 是否权限 | 节点key | 描述"
echo "|类型 | 节点名称 | 是否权限 | 节点key | 描述" >> "output${currentTimeStamp}.md"
echo "| ------------ | ------------ | ------------ | ------------ | ------------ |"
echo "| ------------ | ------------ | ------------ | ------------ | ------------ |" >> "output${currentTimeStamp}.md"

# 遍历每个url和desc，并输出
for i in "${!url_ary[@]}"; do
  echo "|商家PC服务端 | ${desc_ary[$i]} | 是 | $selected${url_ary[$i]} |"
  echo "|商家PC服务端 | ${desc_ary[$i]} | 是 | $selected${url_ary[$i]} |" >> "output${currentTimeStamp}.md"
done
# 遍历每个url和desc，并输出
#for i in "${!desc[@]}"; do
#  printf "|商家PC服务端 | %s | 是 | %s |\n" "${desc[$i]}" "${url[$i]}"
#done


