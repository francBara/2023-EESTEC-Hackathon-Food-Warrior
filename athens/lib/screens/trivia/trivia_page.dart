import 'package:athens/model/trivia/trivia.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';
import 'answer_tile.dart';

class TriviaPage extends StatefulWidget {
  final Trivia trivia;

  const TriviaPage(this.trivia);

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  final ThemeModel theme = ThemeModel.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Trivia',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: theme.gradientList[1]),
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.trivia.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ))),
          SizedBox(height: 30),
          Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Builder(builder: (context) {
                    final List<Widget> answerTiles = [];

                    for (int i = 0; i < widget.trivia.answers.length; i++) {
                      answerTiles.add(Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: AnswerTile(widget.trivia, i),
                      ));
                    }

                    return Column(children: answerTiles);
                  })))
        ],
      )),
    );
  }
}
