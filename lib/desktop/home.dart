import 'package:campus_shared_notes/desktop/home/home_detail.dart';
import 'package:campus_shared_notes/desktop/usercenter/userpage.dart';
import 'package:campus_shared_notes/desktop/whiteboard/whiteboard.dart';
import 'package:flutter/material.dart';

class DesktopHomePage extends StatefulWidget {
  @override
  _DesktopHomePageState createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(), // 首页内容
    WhitePaper(),
    UserProfilePage(),
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
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/113085336?s=400&u=0656989cab9cee7951598f6af2e8ad5486fbd1f7&v=4',
                ),
                backgroundColor: Colors.grey[300],
              ),
            ),
            labelType: NavigationRailLabelType.none,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: SizedBox.shrink(),
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.draw),
                label: SizedBox.shrink(),
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: SizedBox.shrink(),
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
            ],
            backgroundColor: const Color(0xFFF5F5F5),
            useIndicator: true,
            indicatorColor: Color(0xFFE9E9E9),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
