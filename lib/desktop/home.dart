import 'package:campus_shared_notes/desktop/home/home_detail.dart';
import 'package:flutter/material.dart';

class DesktopHomePage extends StatefulWidget {
  @override
  _DesktopHomePageState createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  int _selectedIndex = 0;

  // 定义右侧显示的模块
  final List<Widget> _pages = [
    HomePageContent(),
    Center(child: Text('消息内容')),
    Center(child: Text('个人中心内容')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航栏
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('首页'),
                indicatorColor: Colors.white,
              ),
              NavigationRailDestination(
                icon: Icon(Icons.message),
                label: Text('笔记'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('个人中心'),
              ),
            ],
            backgroundColor: Colors.grey,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // 右侧内容区域，显示对应的模块
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
