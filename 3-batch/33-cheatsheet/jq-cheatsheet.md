# 🧩 jq 命令速查表 (Cheat Sheet)

> jq 是命令行下用于解析、过滤、修改、格式化 JSON 数据的强大工具。

---

## 📦 一、安装与基础

### ✅ 安装

```bash
# Debian/Ubuntu
sudo apt install jq

# macOS
brew install jq
```

### ✅ 查看版本

```bash
jq --version
```

### ✅ 基本语法

```bash
jq '<表达式>' [文件]
```

或通过管道：

```bash
cat file.json | jq '<表达式>'
```

---

## 🧱 二、基础示例

假设 `data.json` 内容如下：

```json
{
  "name": "Alice",
  "age": 25,
  "skills": ["Java", "Python", "Go"],
  "address": {
    "city": "Beijing",
    "zip": "100000"
  },
  "projects": [
    {"id": 1, "name": "Alpha"},
    {"id": 2, "name": "Beta"}
  ]
}
```

### 🔹 查看格式化 JSON
```bash
jq '.' data.json
```

### 🔹 访问字段
```bash
jq '.name' data.json        # "Alice"
jq '.address.city' data.json  # "Beijing"
```

### 🔹 访问数组元素
```bash
jq '.skills[0]' data.json    # "Java"
jq '.skills[]' data.json     # 遍历数组
```

### 🔹 访问对象数组字段
```bash
jq '.projects[].name' data.json
# "Alpha"
# "Beta"
```

---

## 🔍 三、条件与过滤

### 🔹 按条件筛选对象
```bash
jq '.projects[] | select(.id == 2)' data.json
# {"id":2,"name":"Beta"}
```

### 🔹 筛选后取字段
```bash
jq '.projects[] | select(.id == 2) | .name' data.json
# "Beta"
```

### 🔹 组合筛选
```bash
jq '.projects[] | select(.id > 1 and .name == "Beta")' data.json
```

---

## ⚙️ 四、修改与构造

### 🔹 添加字段
```bash
jq '. + {country: "China"}' data.json
```

### 🔹 修改字段
```bash
jq '.age = 30' data.json
```

### 🔹 删除字段
```bash
jq 'del(.address.zip)' data.json
```

### 🔹 构造新 JSON 对象
```bash
jq '{username: .name, city: .address.city}' data.json
# {"username":"Alice","city":"Beijing"}
```

---

## 🧮 五、数组操作

```bash
jq '.skills | length' data.json         # 数组长度
jq '.skills | sort' data.json           # 排序
jq '.skills | map( . + "语言")' data.json  # 处理数组每个元素
jq '[.projects[].name]' data.json       # 提取为新数组
```

---

## 🧰 六、Shell 结合使用

### 🔹 从命令输出读取 JSON
```bash
curl -s https://api.github.com/users/octocat | jq '.login'
```

### 🔹 变量传递
```bash
CITY="Shanghai"
jq --arg city "$CITY" '.address.city = $city' data.json
```

### 🔹 从文件读取外部 JSON
```bash
jq --slurpfile conf config.json '. + {config: $conf[0]}' data.json
```

---

## 🧩 七、输出控制

| 参数 | 作用 |
|------|------|
| `-r` | 原始输出（去掉引号） |
| `-c` | 压缩输出（单行） |
| `-s` | 将多个 JSON 合并为数组 |
| `--arg name val` | 传递字符串变量 |
| `--slurpfile name file` | 引入外部 JSON 文件 |

例：
```bash
jq -r '.name' data.json     # 输出: Alice (不带引号)
jq -c '.' data.json         # 压缩单行输出
```

---

## 🧩 八、复杂操作示例

### 🔹 筛选条件生成数组
```bash
jq '[.projects[] | select(.id > 1) | .name]' data.json
# ["Beta"]
```

### 🔹 多字段格式化输出
```bash
jq -r '.projects[] | "\(.id): \(.name)"' data.json
# 1: Alpha
# 2: Beta
```

### 🔹 提取对象键名
```bash
jq 'keys' data.json
# ["address", "age", "name", "projects", "skills"]
```

### 🔹 修改数组中对象
```bash
jq '.projects |= map(if .id == 1 then .name = "Gamma" else . end)' data.json
```

---

## ⚡ 九、实战场景

### ✅ Docker
```bash
docker images --format '{{json .}}' | jq -r '.Repository'
```

### ✅ Kubernetes
```bash
kubectl get pods -o json | jq -r '.items[].metadata.name'
```

### ✅ REST API 数据
```bash
curl -s https://jsonplaceholder.typicode.com/users | jq '.[].email'
```

---

## 🧠 十、调试与技巧

### ✅ 测试表达式
```bash
echo '{"x":10,"y":20}' | jq '{sum: (.x + .y)}'
# {"sum":30}
```

### ✅ 合并多个 JSON 文件
```bash
jq -s 'add' file1.json file2.json
```

### ✅ 格式化不规范 JSON
```bash
cat raw.txt | jq .
```

---

## 📘 十一、常用表达式速查

| 操作 | 表达式 | 说明 |
|------|----------|------|
| 取字段 | `.key` | 获取键值 |
| 取数组第一个 | `.[0]` | |
| 遍历数组 | `.[]` | |
| 取嵌套 | `.a.b.c` | |
| 删除字段 | `del(.key)` | |
| 添加字段 | `. + {new:1}` | |
| 条件过滤 | `select(.id > 1)` | |
| 字符串拼接 | `"值为: \(.id)"` | |
| 数组映射 | `map(.+1)` | |

---

## 📎 十二、更多学习资源

- 官方文档: [https://stedolan.github.io/jq/manual/](https://stedolan.github.io/jq/manual/)
- jqPlay 在线实验平台: [https://jqplay.org/](https://jqplay.org/)
- jq Cookbook: [https://github.com/stedolan/jq/wiki/Cookbook](https://github.com/stedolan/jq/wiki/Cookbook)
