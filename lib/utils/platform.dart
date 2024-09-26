import 'package:flutter/foundation.dart'; // 导入这个包
import 'package:flutter/material.dart';

class PlatformUIAdapter extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;

  const PlatformUIAdapter({
    super.key,
    required this.desktop,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return desktop; // 针对Web的处理
    } else {
      // 在移动设备上使用的Platform类
      return (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android)
          ? mobile
          : desktop;
    }
  }
}
