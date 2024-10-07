import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:archive/archive.dart';
import 'package:mime/mime.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? serverUrl;

  @override
  void initState() {
    super.initState();
    _startServer();
  }

  Future<void> _startServer() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String gameDirPath = '${appDocDir.path}/game';

    // 检查是否已经解压并且没有正在解压的标志文件存在。
    if (!await File('$gameDirPath/complete014.txt').exists()) {
      await Directory(gameDirPath).create(recursive: true);

      // 解压游戏文件到指定目录。
      await _unzipGame(appDocDir, gameDirPath);

      // 创建完成标志文件以避免重复解压。
      await File('$gameDirPath/complete014.txt').writeAsString('done');
    }

    serverUrl = 'http://localhost:8080/index.html';

    // 启动 HTTP Server.
    var handler = const Pipeline()
        .addMiddleware(logRequests())
        .addHandler((request) => _serveFiles(request, gameDirPath));

    await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 8080);

    setState(() {});
  }

  Future<void> _unzipGame(Directory appDocDir, String targetPath) async {
    final byteData = await rootBundle.load('assets/game.zip');
    final buffer = byteData.buffer.asUint8List();

    // 写入 zip 文件到本地目录
    File('${appDocDir.path}/game.zip').writeAsBytesSync(buffer);

    final bytes = await File('${appDocDir.path}/game.zip').readAsBytes();

    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filename = '$targetPath/${file.name}';

      if (file.isFile) {
        final data = file.content as List<int>;
        File(filename)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        await Directory(filename).create(recursive: true);
      }
    }
    return;
  }

  Response _serveFiles(Request request, String gameDir) {
    final path = request.url.toString();
    final filePath = '$gameDir/$path';

    final file = File(filePath);
    if (file.existsSync()) {
      return Response.ok(file.openRead(),
          headers: {'Content-Type': _getContentType(path)});
    } else {
      return Response.notFound('File not found');
    }
  }

  String _getContentType(String path) {
    // 使用 mime 库来获取内容类型
    final contentType = lookupMimeType(path);
    return contentType ?? 'application/octet-stream';
  }

  @override
  Widget build(BuildContext context) {
    // 全屏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    return serverUrl == null
        ? const Center(child: CircularProgressIndicator())
        : WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(serverUrl!)));
  }
}
