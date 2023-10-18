import 'package:athens/constants/theme_model.dart';
import 'package:athens/model/wiki/article.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/screens/wiki/article_page.dart';
import 'package:flutter/material.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  ArticleTile(this.article);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () {
        Routing.slideToPage(context, ArticlePage(article));
      },
      child: Container(
          height: 260,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColorLight,
              boxShadow: [ThemeModel.instance.shadow]),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    article.content.substring(0, 60) + '...',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ],
          )),
    );
  }
}
