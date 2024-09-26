import 'package:campus_shared_notes/desktop/home.dart';
import 'package:campus_shared_notes/utils/platform.dart';
import 'package:flutter/material.dart';

import 'mobile/home.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations( // 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // 全屏显

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "校园笔记",
      theme: ThemeData(
        // 定义主色调，次级色调和卡片颜色
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white, // 卡片背景色
        // textTheme: const TextTheme(
        //   headlineSmall: TextStyle(
        //     color: Colors.black87,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        //   bodyMedium: TextStyle(color: Colors.black54),
        // ),
      ),
      home: PlatformUIAdapter(
        desktop: DesktopHomePage(),
        mobile: MobileHomePage(),
      ),
    );
  }
}
