import 'package:uuid/uuid.dart';

class UUIDGenerator {
  static final Uuid _uuid = Uuid();

  // 私有构造函数，防止实例化
  UUIDGenerator._();

  // 生成一个随机UUID
  static String generate() {
    return _uuid.v4();
  }
}
