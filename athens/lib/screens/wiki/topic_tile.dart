import 'package:athens/model/wiki/topic.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/screens/wiki/topic.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;
  final ThemeModel theme = ThemeModel.instance;
  final ShapeBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)));
  final containerRadius = BorderRadius.all(Radius.circular(25));

  TopicTile(this.topic);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () {
        Routing.slideToPage(context, EcoTopic(topic));
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: cardShape,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              gradient: theme.gradient, borderRadius: containerRadius),
          child: ListTile(
            title: Text(topic.title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
