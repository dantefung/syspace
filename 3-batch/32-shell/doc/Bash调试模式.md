在 **bash/sh** 脚本里，

* `set -x` 会打开 **调试模式**（执行每条命令前会打印到终端）。
* 要关闭它，只需执行：

```bash
set +x
```

这样就会关闭调试输出。

---

⚡ 常见用法：
如果你只想在某一段代码里调试，可以这样写：

```bash
echo "before debug"

set -x   # 开启调试
ls /tmp
pwd
set +x   # 关闭调试

echo "after debug"
```

这样只有中间那段会输出调试信息。


