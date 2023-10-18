import 'dart:ui';

class Topic {
  late final String id;
  late final String title;
  late final Color color;
  String? imageLink;

  Topic(Map<String, dynamic> topicMap) {
    id = topicMap['id'];
    title = topicMap['title'];
    color = _fromHex(topicMap['color']);
  }
  Topic.manual(String title, String color) {
    this.title = title;
    this.color = _fromHex(color);
  }

  Color _fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
