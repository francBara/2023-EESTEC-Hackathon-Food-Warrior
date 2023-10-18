import 'package:athens/model/wiki/article.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                SizedBox(height: 24),
                Hero(
                  tag: 'ArticleCover' + article.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: article.imageLink != null
                        ? Image.network(
                            article.imageLink!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            //height: 100,
                            color: Colors.grey,
                          ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  article.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
