import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String avatarUrl =
      'https://avatars.githubusercontent.com/u/113085336?s=400&u=0656989cab9cee7951598f6af2e8ad5486fbd1f7&v=4';
  final String username = 'JohnDoe';
  final String bio = 'Flutter Developer | Open Source Enthusiast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息部分
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 用户头像
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  SizedBox(width: 16),
                  // 用户名称和简介
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          bio,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 16),
                        // Follow按钮
                        ElevatedButton(
                          onPressed: () {
                            // Follow/Unfollow功能
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('Follow'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 统计信息部分
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Repositories', '42'),
                  _buildStatColumn('Followers', '1.2k'),
                  _buildStatColumn('Following', '98'),
                ],
              ),
            ),

            Divider(),

            // Tabs
            DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab 标题部分
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Repositories'),
                      Tab(text: 'Followers'),
                      Tab(text: 'Following'),
                    ],
                  ),
                  // Tab 内容部分
                  Container(
                    height: 400, // 可以根据需要调整高度
                    child: TabBarView(
                      children: [
                        _buildRepositoriesTab(),
                        _buildFollowersTab(),
                        _buildFollowingTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建统计信息
  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  // 构建 Repositories Tab
  Widget _buildRepositoriesTab() {
    // 模拟一些仓库信息
    final repositories = [
      {'name': 'Flutter Project', 'description': 'A sample Flutter project'},
      {'name': 'Dart Package', 'description': 'A helpful Dart package'},
      {'name': 'Open Source Repo', 'description': 'Open to contributions'},
    ];

    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            repositories[index]['name']!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(repositories[index]['description']!),
          trailing: Icon(Icons.star, color: Colors.yellow),
        );
      },
    );
  }

  // 构建 Followers Tab
  Widget _buildFollowersTab() {
    // 模拟一些粉丝信息
    final followers = ['Alice', 'Bob', 'Charlie'];

    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(followers[index][0]), // 显示粉丝名称首字母
          ),
          title: Text(followers[index]),
        );
      },
    );
  }

  // 构建 Following Tab
  Widget _buildFollowingTab() {
    // 模拟关注信息
    final following = ['Dave', 'Emma', 'Frank'];

    return ListView.builder(
      itemCount: following.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(following[index][0]), // 显示关注者名称首字母
          ),
          title: Text(following[index]),
        );
      },
    );
  }
}
