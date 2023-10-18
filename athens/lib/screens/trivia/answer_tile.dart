import 'package:athens/model/trivia/trivia.dart';
import 'package:athens/model/trivia/trivia_solution.dart';
import 'package:athens/screens/trivia/trivia_solution_page.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/overlay_loader.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/trivia_service.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';

class AnswerTile extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;
  final Trivia trivia;
  final int index;

  AnswerTile(this.trivia, this.index);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () async {
        try {
          trivia.selectAnswer(index);
          OverlayLoader.showLoading(context);
          final TriviaSolution solution = await TriviaProxy.submitAnswer(trivia, index);
          OverlayLoader.unshowLoading();
          Routing.moveToPage(context, TriviaSolutionPage(trivia, solution));
        } catch(e) {
          OverlayLoader.unshowLoading();
        }
      },
      child: Container(
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: theme.maincolor),
          padding: EdgeInsets.all(15),
          child: Container(
              child: Text(
            trivia.answers[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ))),
    );
  }
}
