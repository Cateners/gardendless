# PVZ2 Gardendless安卓移植

实际上，就是给web版本加上简单的触摸转鼠标事件代码并打了个包，并非完美的移植。

手指点击等同于鼠标单击，手指划动等同于鼠标拖拽，两只手指划动等同于鼠标滚轮。游戏里大部分界面都可以直接划动，“设置”界面应该是唯一需要使用滚轮的地方（0.4.2版本）。另外网页版似乎默认开启了作弊，可以在设置界面关闭。

从0.6.3版本开始支持模拟鼠标右键单击。方法是，首先把两个手指放在屏幕上任意位置，然后用第三个手指点击你想按鼠标右键的位置。虽然这种方式不太优雅但是~~代码实现非常简单~~也足够用了。你应该只需要用它来修改或删除卡组。

受限于手机内存，可能出现关卡闪退、音乐或音效加载失败等问题。实测在0.3版本时，8GB内存可游玩埃及关卡，12GB内存音效丢失情况缓解，推测16GB内存可正常游玩。这和官网对[系统和环境的要求](https://pvzge.com/guide/requirement.html)基本一致，即最低12GB内存，推荐16GB内存。

要编译，首先把[web版本](https://github.com/Gzh0821/pvzge_web)游戏本体(位于docs)添加补丁(touchPatch.js)后打包并重命名为game.zip，然后扔到assets文件夹。

接下来正常用flutter框架编译即可。详细步骤可参考`.github\workflows\main.yml`

如果想下载已编译的安装包，请前往[releases](https://github.com/Cateners/gardendless/releases)页面，下载Assets内的apk文件。

# PVZ2 Gardendless Android Port

Actually, it's just the web version with simple touch-to-mouse event code added and packaged—not a perfect port.

A finger tap is equivalent to a mouse click, a finger swipe is equivalent to a mouse drag, and a two-finger swipe is equivalent to a mouse wheel. Most interfaces in the game can be directly swiped, and the "Settings" interface is likely the only place where the mouse wheel is needed (version 0.4.2). Additionally, the web version seems to have cheats enabled by default, which can be turned off in the settings interface.

Starting from version 0.6.3, simulated right-click functionality is supported. The method is: first place two fingers anywhere on the screen, then use a third finger to tap where you want the right-click to occur. While this method is not very elegant, it’s ~~extremely simple to implement~~ sufficient for its intended use. You’ll likely only need it to modify or delete card decks.

Due to limitations in mobile device memory, issues such as level crashes or failure to load music/sound effects may occur. Testing in version 0.3 showed that devices with 8GB of memory can run the Egypt levels, while 12GB of memory alleviates sound effect loss. It is estimated that 16GB of memory would allow for normal gameplay. This is largely consistent with the [system requirements](https://pvzge.com/en/guide/requirement.html) stated on the official website, which specify a minimum of 12GB RAM and recommend 16GB RAM.

To compile, first add the patch (touchPatch.js) to the game files (located in docs) from the [web version](https://github.com/Gzh0821/pvzge_web), then package and rename it as game.zip, and place it in the assets folder.

After that, compile normally using the Flutter framework. For detailed steps, refer to `.github\workflows\main.yml`.

If you want to download the pre-compiled APK, visit the [releases](https://github.com/Cateners/gardendless/releases) page and download the APK file from the Assets section.

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