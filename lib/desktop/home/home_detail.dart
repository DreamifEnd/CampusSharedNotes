import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'carousel_widget.dart';
import 'course_grid_widget.dart';

// 首页内容
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 轮播图组件
          CarouselWidget(),
          SizedBox(height: 20),
          // 标题
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '推荐课程',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // 自适应课程网格组件
          CourseGridWidget(),
        ],
      ),
    );
  }
}
