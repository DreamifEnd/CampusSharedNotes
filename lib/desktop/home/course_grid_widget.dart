import 'package:flutter/material.dart';

import 'course_detail.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
            ? 3
            : 2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemCount: _courses.length,
        itemBuilder: (context, index) {
          return CourseCard(courses: _courses, index: index);
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required List<Map<String, String>> courses,
    required this.index,
  }) : _courses = courses;

  final List<Map<String, String>> _courses;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print("$screenWidth $screenHeight");
    return InkWell(
      onTap: () {
        // 点击进入详情页
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              course: _courses[index],
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                _courses[index]['image']!,
                height: screenWidth > 1700 && screenHeight > 970
                    ? 160
                    : screenHeight > 800
                        ? 140
                        : screenHeight > 300
                            ? 100
                            : 60,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _courses[index]['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: screenWidth > 1700 && screenHeight > 970
                        ? 30
                        : screenHeight > 800
                            ? 10
                            : screenHeight > 300
                                ? 2
                                : 0,
                  ),
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
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
