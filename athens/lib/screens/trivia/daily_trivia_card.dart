import 'package:athens/constants/theme_model.dart';
import 'package:athens/model/trivia/trivia.dart';
import 'package:athens/screens/trivia/trivia_page.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/trivia_service.dart';
import 'package:flutter/material.dart';

class DailyTrivia extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;
  final containerRadius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Trivia>(
        future: TriviaProxy.getDailyTrivia(),
        builder: (context, trivia) {
          Widget child;
          if (trivia.hasData) {
            child = Clickable(
              onTap: () {
                Routing.slideToPage(context, TriviaPage(trivia.data!));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 170,
                child: GestureDetector(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          gradient: theme.gradientList[5],
                          borderRadius: containerRadius),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            alignment: Alignment.topLeft,
                            child: Text(
                              trivia.requireData.availablePoints > 0 ?
                              "Daily Quest\nGet your ${trivia.requireData.availablePoints} points!" :
                              'Daily Quest\nNo more points available',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, top: 5),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Only ${trivia.requireData.correctAnswers} answered',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 15, top: 10),
                                child: Text(
                                  'How much do you\nknow about food waste?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 15),
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (trivia.hasError) {
            child = SizedBox();
          } else {
            child = Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 200,
            );
          }
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 200),
              child: child);
        });
  }
}
