import 'dart:io';

import 'package:file_selector/file_selector.dart'; // 新增
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:path_provider/path_provider.dart';

class NoteEditorPage extends StatefulWidget {
  @override
  _NoteEditorPageState createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  // 读取默认存储的笔记内容（非"另存为"部分）
  Future<void> _loadNote() async {
    // 这里是加载的逻辑，也可以省略
  }

  // 使用"另存为"对话框来保存文件
  Future<void> _saveNoteAs() async {
    final XFile? file = (await getSaveLocation(
      suggestedName: 'note.md',
    )) as XFile?;
    if (file != null) {
      final File localFile = File(file.path);
      await localFile.writeAsString(_controller.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('笔记已保存到 ${file.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑笔记'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNoteAs, // 使用"另存为"保存笔记
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          decoration: InputDecoration(
            hintText: '输入你的 Markdown 笔记...',
          ),
        ),
      ),
    );
  }
}

class MarkdownPreviewPage extends StatefulWidget {
  @override
  _MarkdownPreviewPageState createState() => _MarkdownPreviewPageState();
}

class _MarkdownPreviewPageState extends State<MarkdownPreviewPage> {
  String _markdownData = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    final path = await _getNoteFilePath();
    final file = File(path);
    try {
      final contents = await file.readAsString();
      setState(() {
        _markdownData = contents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _markdownData = '加载失败';
        _isLoading = false;
      });
    }
  }

  Future<String> _getNoteFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/note.md';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('预览 Markdown')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              height: double.infinity, // 或者设置具体高度
              child: MarkdownWidget(data: _markdownData),
            ),
    );
  }
}

class Markdownshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // 跳转到编辑页面
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NoteEditorPage()),
              );
            },
            child: Text('编辑笔记'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 跳转到预览页面
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MarkdownPreviewPage()),
              );
            },
            child: Text('预览 Markdown'),
          ),
        ],
      ),
    );
  }
}
