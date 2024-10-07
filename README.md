# PVZ2 Gardendless安卓移植

实际上，就是给web版本加上简单的触摸转鼠标事件代码并打了个包，并非完美的移植。
比如捡阳光时需要像水果忍者那样划过去，直接点击是没用的。
骆驼牌基本上翻不了......

好在大多数时候正常游玩是没问题的，比如种植物（可以点击不能拖放），拖矿车，冰仙子和椰子炮的使用等等。

我测试了四台设备。
红米Turbo3（安卓14、骁龙8sgen3、12+256）和摩托罗拉edge s pro（安卓13、骁龙870、12+256）可以正常游玩。
海信A7cc（安卓10、展锐T5710、6+128）加载一会后会报错加固插件版本太低，不支持当前安卓版本。
红魔3D平板（安卓13、骁龙8gen2、12+256）游玩一会后会闪退。

要编译，首先把web版本打包并重命名为game.zip，然后扔到assets文件夹。
然后正常编译即可。

# gardendless

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
