import 'dart:io';

import 'package:flutter/material.dart';
class PlatformUIAdapter extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  const PlatformUIAdapter({super.key, required this.desktop, required this.mobile,});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return mobile;
    } else {
      return desktop;
    }
  }
}
