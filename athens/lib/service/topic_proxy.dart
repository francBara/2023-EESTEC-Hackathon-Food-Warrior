import 'package:athens/model/wiki/topic.dart';
import 'package:athens/service/skeleton/database.dart';

class TopicProxy {
  static Future<List<Topic>> getTopics() async {
    return (await Database.getAll('topics'))
        .map((topicMap) => Topic(topicMap))
        .toList();
  }
}
