import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../utils/uuid.dart';
import 'component/paint_setting_dialog.dart';
import 'model/line.dart';
import 'model/paint_model.dart';
import 'model/point.dart';
import 'paper_painter.dart';

class WhitePaper extends StatefulWidget {
  @override
  _WhitePaperState createState() => _WhitePaperState();
}

enum TransformType {
  none,
  translate,
  rotate,
  scale,
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();

  String whiteBoardId = UUIDGenerator.generate();

  ValueNotifier<TransformType> type =
      ValueNotifier<TransformType>(TransformType.none);

  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;
  Color lineColor = Colors.black;
  double strokeWidth = 1;
  late StompClient stompClient;
  // final channel = WebSocketChannel.connect(
  //   Uri.parse('ws://localhost:8080/ws'),
  // );

  @override
  void initState() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws',
        onConnect: (StompFrame frame) {
          print('Connected to WebSocket');

          // 订阅特定白板ID的主题
          // stompClient.subscribe(
          //   destination: '/topic/lines/$whiteBoardId',
          //   callback: (StompFrame frame) {
          //     // 处理接收到的线条数据
          //     print('Received: ${frame.body}');
          //   },
          // );
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket错误: $error');
        },
        onStompError: (StompFrame frame) {
          print('STOMP错误: ${frame.body}');
        },
      ),
    );

    stompClient.activate();
  }

  @override
  void dispose() {
    paintModel.dispose();
    type.dispose();
    stompClient.deactivate();
    //channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: _showSettingDialog,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: _onScaleEnd,
            onLongPressStart: _activeEdit,
            onLongPressUp: _cancelEdit,
            onLongPressMoveUpdate: _moveEdit,
            onDoubleTap: _clear,
            child: CustomPaint(
                size: MediaQuery.of(context).size,
                painter: PaperPainter(model: paintModel))),
        //Positioned(right: 20, top: 10, child: _buildTools())
        Align(alignment: Alignment.topCenter, child: _buildTools()),
        Positioned(
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                print(paintModel.lines);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _clear() {
    paintModel.clear();
  }

  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
              initColor: lineColor,
              initWidth: strokeWidth,
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
            ));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  void _activeEdit(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _cancelEdit() {
    paintModel.cancelEditLine();
  }

  void _moveEdit(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }

  static const List<IconData> icons = [
    Icons.edit,
    Icons.api,
    Icons.rotate_90_degrees_ccw_sharp,
    Icons.expand,
  ];

  Widget _buildTools() {
    return ValueListenableBuilder(
      valueListenable: type,
      builder: (_, value, __) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: icons.asMap().keys.map((index) {
            bool active = value == TransformType.values[index];
            return IconButton(
                onPressed: () => type.value = TransformType.values[index],
                icon: Icon(
                  icons[index],
                  color: active ? Colors.blue : Colors.grey,
                ));
          }).toList(),
        ),
      ),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    switch (type.value) {
      case TransformType.none:
        Line line = Line(color: lineColor, strokeWidth: strokeWidth);
        paintModel.pushLine(line);
        break;
      case TransformType.translate:
        if (details.pointerCount == 1) {
          _offset = details.focalPoint;
        }
        break;
      case TransformType.rotate:
        break;
      case TransformType.scale:
        break;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.pushPoint(Point.fromOffset(details.localFocalPoint));
        break;
      case TransformType.translate:
        double dx = details.focalPoint.dx - _offset.dx;
        double dy = details.focalPoint.dy - _offset.dy;

        paintModel.matrix =
            Matrix4.translationValues(dx, dy, 1).multiplied(recodeMatrix);

        break;
      case TransformType.rotate:
        paintModel.matrix =
            recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));

        break;
      case TransformType.scale:
        if (details.scale == 1.0) return;
        paintModel.matrix = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
        break;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    switch (type.value) {
      case TransformType.none:
        paintModel.doneLine(stompClient, whiteBoardId);
        paintModel.removeEmpty();
        break;
      case TransformType.translate:
      case TransformType.rotate:
      case TransformType.scale:
        recodeMatrix = paintModel.matrix;
        break;
    }
  }
}
