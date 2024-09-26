import 'package:campus_shared_notes/desktop/whiteboard/model/line.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class API {
  static const String baseurl = "http://127.0.0.1:8080/";
  static const String basewsurl = "ws://localhost:8080/ws";

  static Future<void> saveLine(WebSocketChannel channel, Line? line) async {
    channel.sink.add(line);
  }
}
