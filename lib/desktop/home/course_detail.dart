import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/data.dart';

class CourseDetailPage extends StatefulWidget {
  final Map<String, String> course;

  const CourseDetailPage({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // 初始化视频控制器
    _initializePlayer(
        'http://sjfjao1zq.hd-bkt.clouddn.com/%E5%B1%B1%E6%99%9A-%E4%B8%89%E5%8F%B6-%E6%9C%80%E7%BB%88.mp4?e=1727304318&token=Es46IMZqWtyHJtpf9LOfEJMEOHk2YvIVVPPgtt8W:94oKj_p0g-QYCgVZTm--j6x-VwY=');
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // 初始化播放器
  void _initializePlayer(String url) {
    _videoPlayerController = VideoPlayerController.network(url);
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: false,
          allowFullScreen: true,
          allowMuting: true,
        );
      });
    });
  }

  // 切换视频
  void _changeVideo(String videoUrl) {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _initializePlayer(videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course['name']!),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧视频播放区域
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          // 右侧课程视频列表
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CourseChapterList(
                onVideoSelected: (String videoUrl) {
                  _changeVideo(videoUrl);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 右侧章节列表和视频
class CourseChapterList extends StatelessWidget {
  final Function(String) onVideoSelected;

  CourseChapterList({required this.onVideoSelected});

  final List<Map<String, dynamic>> _chapters = Data.chapters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _chapters.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            initiallyExpanded: index == 0, // 默认展开第一个章节
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.grey[200],
            iconColor: Colors.blue,
            collapsedIconColor: Colors.blue,
            title: Text(
              _chapters[index]['chapter'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            children: _chapters[index]['videos'].map<Widget>((video) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Text(
                    video['title'],
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(
                    Icons.play_circle_fill,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    onVideoSelected(video['url']);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
