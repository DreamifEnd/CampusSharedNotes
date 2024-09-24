import 'package:flutter/material.dart';

class CourseGridWidget extends StatelessWidget {
  final List<Map<String, String>> _courses = [
    {
      'name': '课程 1',
      'school': '学校 A',
      'image': 'https://via.placeholder.com/300x200?text=Course+1',
      'views': '1200'
    },
    {
      'name': '课程 2',
      'school': '学校 B',
      'image': 'https://via.placeholder.com/300x200?text=Course+2',
      'views': '900'
    },
    {
      'name': '课程 3',
      'school': '学校 C213213213213213',
      'image': 'https://via.placeholder.com/300x200?text=Course+3',
      'views': '3500'
    },
    {
      'name': '课程 4',
      'school': '学校 D',
      'image': 'https://via.placeholder.com/300x200?text=Course+4',
      'views': '500'
    },
    {
      'name': '课程 5',
      'school': '学校 E',
      'image': 'https://via.placeholder.com/300x200?text=Course+5',
      'views': '2700'
    },
    {
      'name': '课程 6',
      'school': '学校 F',
      'image': 'https://via.placeholder.com/300x200?text=Course+6',
      'views': '600'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 获取屏幕宽度，根据宽度决定每行显示的课程数量
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
            ? 3
            : 2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true, // 避免GridView无限扩展
        physics:
            NeverScrollableScrollPhysics(), // 禁止GridView自身滚动，交给外部的ScrollView滚动
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // 动态列数
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2, // 控制每个格子的宽高比
        ),
        itemCount: _courses.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // 圆角
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 上方课程图片部分
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15), // 图片的圆角
                  ),
                  child: Image.network(
                    _courses[index]['image']!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // 下方课程详情部分
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _courses[index]['name']!,
                        style: TextStyle(
                          fontSize: 18, // 字体稍大
                          fontWeight: FontWeight.bold, // 加粗
                        ),
                      ),
                      // 课程名称和观看人数
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_courses[index]['views']} 人观看',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _courses[index]['school']!,
                            style: TextStyle(
                              fontSize: 14, // 字体稍小
                              color: Colors.grey, // 字体颜色淡一点
                            ),
                          ),
                        ],
                      ),
                      // 课程学校
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
