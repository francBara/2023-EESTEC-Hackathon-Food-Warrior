import 'package:athens/model/wiki/article.dart';
import 'package:athens/model/wiki/topic.dart';
import 'package:athens/service/skeleton/database.dart';

class ArticleProxy {
  static Future<List<Article>> getArticles(Topic topic) async {
    return (await Database.getAll('topics/' + topic.id + '/articles'))
        .map((articleMap) => Article(articleMap))
        .toList();
  }
}
