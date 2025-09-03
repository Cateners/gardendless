# PVZ2 Gardendless安卓移植

实际上，就是给web版本加上简单的触摸转鼠标事件代码并打了个包，并非完美的移植。

受限于手机内存，可能出现关卡闪退、音乐或音效加载失败等问题。实测在0.3版本时，8GB内存可游玩埃及关卡，12GB内存音效丢失情况缓解，推测16GB内存可正常游玩。

要编译，首先把[web版本](https://github.com/Gzh0821/pvzge_web)游戏本体(位于docs)添加补丁(touchPatch.js)后打包并重命名为game.zip，然后扔到assets文件夹。

接下来正常编译即可。

# PVZ2 Gardendless Android Port

Actually, it's just the web version with simple touch-to-mouse event code added and packaged—not a perfect port.

Due to limitations in mobile device memory, issues such as level crashes or failure to load music/sound effects may occur. Testing in version 0.3 showed that devices with 8GB of memory can run the Egypt levels, while 12GB of memory alleviates sound effect loss. It is estimated that 16GB of memory would allow for normal gameplay.

To compile, first add the patch (touchPatch.js) to the game files (located in docs) from the [web version](https://github.com/Gzh0821/pvzge_web), then package and rename it as game.zip, and place it in the assets folder.

After that, proceed with normal compilation.

## 签名

签名已暴露在仓库中（keystore.jks），这意味着任何人都可以编译一份覆盖当前版本的安装包。为了安全请仅从此处下载。

The signature has been exposed in the repository (keystore.jks), which means anyone can compile an installation package that could overwrite the currently installed version. For security reasons, please download only from this source.

## 自动化编译

仓库每天会检测gardendless web版本更新，如有更新会自动构建安卓版本。这部分代码主要由DeepSeek完成，prompt如下：

```
帮我用GitHub Actions实现，告诉我详细操作步骤：
每天检查https://github.com/Gzh0821/test_pvz2仓库更新。如有更新，实现
1、将其克隆，在位于test_pvz2/docs/index.html的</body>前添加一段代码（位于gardendless/touchPatch.js，gardendless稍后会提到），然后将docs内所有文件和文件夹打包到game.zip；
2、我的仓库https://github.com/Cateners/gardendless是一个flutter安卓项目。把打包好的game.zip放到gardendless/assets/game.zip。
3、gardendless/lib/main.dart有两处字符串包含"complete.txt"，需要用最近的test_pvz2的commit更新信息替换。比如，test_pvz2的commit更新信息为"update version 0.2.8"，所以把"complete.txt"替换为"0.2.8.txt"。假如最新的commit信息没有检测到版本号，就用commit值代替，如把"complete.txt"替换为"38ddf864b3fcc2dcc6765e2db786c11a2e0734ad.txt"。
4、把gardendless/pubspec.yaml的版本号根据test_pvz2检测到的版本号更新（如"update version 0.2.8"版本号为0.2.8）。如果检测不到就不修改版本号。并且如果条件满足，对依赖进行更新。
5、把对gardendless/pubspec.yaml的更新commit到https://github.com/Cateners/gardendless。
6、编译gardendless，并把apk文件作为release提交到https://github.com/Cateners/gardendless。
```