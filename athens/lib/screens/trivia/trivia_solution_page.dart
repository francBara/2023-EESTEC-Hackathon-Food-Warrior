import 'package:athens/model/trivia/trivia.dart';
import 'package:athens/model/trivia/trivia_solution.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';

class TriviaSolutionPage extends StatelessWidget {
  final Trivia trivia;
  final TriviaSolution solution;
  final ThemeModel theme = ThemeModel.instance;

  TriviaSolutionPage(this.trivia, this.solution);

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = trivia.isAnswerCorrect(solution);
    final int answerIndex = solution.correctAnswerIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCorrect ? 'Congrats!' : 'Unlucky!',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          isCorrect
              ? Icon(Icons.check_circle_outline,
                  color: theme.maincolor, size: 100)
              : Icon(Icons.highlight_remove_rounded,
                  color: Colors.red, size: 100),
          SizedBox(height: 24),
          isCorrect
              ? Text('Eureka! You won ${trivia.availablePoints} points!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900))
              : SizedBox(),
          SizedBox(height: 40,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Text(
              'The correct answer is:\n${trivia.answers[answerIndex]}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Text(
              solution.comment,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 64),
          Container(
            height: 50,
            width: 175,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.maincolor,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                )),
          ),
        ],
      )),
    );
  }
}
