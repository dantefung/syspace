我给你整理一份 **PowerShell 学习路线 + 工具推荐**，从零基础到熟练写脚本。

---

## 一、学习路线

### 1. 基础阶段（入门）

* **认识 PowerShell**

  * PowerShell 是 Windows 上的现代命令行 + 脚本语言，兼具 Bash 的交互性和 .NET 的强大能力。
* **学习基础命令**

  * `Get-Help`：查看帮助（相当于 man）
  * `Get-Command`：找命令
  * `Get-Member`：查看对象的属性/方法
  * 常见命令别名：`ls`(`Get-ChildItem`)、`cat`(`Get-Content`)、`ps`(`Get-Process`)

👉 建议：每天练习几个命令，习惯“面向对象的命令行”。

---

### 2. 提高阶段（脚本编写）

* 学习变量、数组、哈希表（字典）
* 流程控制：`if/else`, `switch`, `for/foreach`, `while`
* 函数定义：`function MyFunc { param($a, $b) ... }`
* 模块管理：`Import-Module` / `Install-Module`
* 错误处理：`try { } catch { } finally { }`

👉 可以从自动化一些日常小任务开始，比如：

* 批量改文件名
* 监控 CPU 内存
* 调用 REST API

---

### 3. 进阶阶段（工程化）

* 学习 **Pipeline 思维**（命令之间通过对象传递）
* 熟悉 **正则表达式** 和 **字符串处理**
* 掌握 **文件与注册表操作**
* 使用 **PowerShell Remoting** 管理远程服务器
* 学习 **脚本模块化**，编写自己的 `.psm1` 模块
* 结合 **.NET 类库**，调用 C# API（比如：`[System.IO.File]::ReadAllText()`）

👉 最终目标：能写出 **可复用脚本 / 自动化工具**，并能在团队里推广。

---

## 二、学习资源推荐

1. **官方文档**

   * [Microsoft Learn - PowerShell](https://learn.microsoft.com/powershell/) （权威教程）
2. **书籍**

   * 《PowerShell in Action》
   * 《Learn Windows PowerShell in a Month of Lunches》 （边学边做，适合初学）
3. **视频课程**

   * YouTube 上的 PowerShell 教学（入门非常快）
   * B站搜索“PowerShell 入门教程”

---

## 三、IDE / 编辑器工具

* **VS Code**（首选）

  * 安装扩展：`PowerShell`（微软官方插件）
  * 功能：语法高亮、智能提示、调试、代码片段、远程开发
* **ISE (Windows 自带 PowerShell ISE)**

  * 适合新手，界面简单直观，但微软已不再更新
* **JetBrains Rider / IntelliJ IDEA**（可装插件支持 PS，但一般不推荐）
* **Neovim / Vim**（你是 Vim 用户，可以装 `powershell.vim` 语法插件）

👉 我的建议是：**日常用 VS Code，快速实验用 PowerShell ISE**。

---

## 四、练习建议

* 每天写一个小脚本（哪怕 10 行）
* 解决身边的自动化需求，比如：

  * 自动清理日志
  * 一键打包部署项目
  * 检查磁盘空间并邮件提醒
* 参与 GitHub 上的 PowerShell 项目，看别人是怎么写的

---


