# PVZ2 Gardendless安卓移植

实际上，就是给web版本加上简单的触摸转鼠标事件代码并打了个包，并非完美的移植。

受限于手机内存，可能出现关卡闪退、音乐加载不出来等问题。

要编译，首先把[web版本](https://github.com/Gzh0821/test_pvz2)游戏本体(位于docs)添加补丁(touchPatch.js)后打包并重命名为game.zip，然后扔到assets文件夹。

接下来正常编译即可。