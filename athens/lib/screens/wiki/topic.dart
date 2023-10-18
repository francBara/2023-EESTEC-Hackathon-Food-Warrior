import 'package:athens/model/wiki/article.dart';
import 'package:athens/model/wiki/topic.dart';
import 'package:athens/screens/utils/loading_indicator.dart';
import 'package:athens/screens/wiki/article_tile.dart';
import 'package:athens/service/article_proxy.dart';
import 'package:flutter/material.dart';

class EcoTopic extends StatelessWidget {
  final Topic topic;

  EcoTopic(this.topic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          topic.title,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Article>>(
                  future: ArticleProxy.getArticles(topic),
                  builder: (context, articles) {
                    if (articles.hasData) {
                      return ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        itemCount: articles.data!.length,
                        itemBuilder: (context, index) {
                          return ArticleTile(articles.data![index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24);
                        },
                      );
                    } else if (articles.hasError) {
                      print('ERROR ' + articles.error.toString());
                      return Center(child: Text('An error occurred'));
                    }
                    return Center(child: LoadingIndicator());
                  }))
        ],
      )),
    );
  }
}
