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
#java_file=$1

# 控制台输入  "D:/a.txt" 注意要带上引号
read -p "请输入文件路径:" java_file

#!/bin/bash

## 解析Java文件，获取所有形如@PostMapping行的中的路径，并存储为url变量
url=$(grep -oE '@PostMapping\("([^"]+)"\)' $java_file | sed 's/@PostMapping("\(.*\)")/\1/')

## 截取形如<p>删除标准车型</p>中<p>内的注释内容，并存储为desc变量
desc=$(grep -oE '<p>([^<]+)</p>' $java_file | sed 's/<p>\(.*\)<\/p>/\1/')

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
  echo "|商家PC服务端 | ${desc_ary[$i]} | 是 | ${url_ary[$i]} |"
  echo "|商家PC服务端 | ${desc_ary[$i]} | 是 | ${url_ary[$i]} |" >> "output${currentTimeStamp}.md"
done
# 遍历每个url和desc，并输出
#for i in "${!desc[@]}"; do
#  printf "|商家PC服务端 | %s | 是 | %s |\n" "${desc[$i]}" "${url[$i]}"
#done


