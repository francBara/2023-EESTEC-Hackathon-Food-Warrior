import 'package:athens/constants/theme_model.dart';
import 'package:athens/model/user.dart';
import 'package:athens/screens/utils/loading_indicator.dart';
import 'package:athens/service/skeleton/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RankingPage extends StatelessWidget {
  RankingPage({Key? key}) : super(key: key);
  final ThemeModel theme = ThemeModel.instance;
  final ShapeBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));
  final containerRadius = BorderRadius.all(Radius.circular(20));
  final double cardHeight = 60;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ref, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async => print(''),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: FutureBuilder<List<FoodUser>>(
                future: Database.getTopUsers(),
                builder: (context, users) {
                  Widget child;
                  if (users.hasData) {
                    child = ListView.builder(
                      key: ValueKey(0),
                      physics: BouncingScrollPhysics(),
                      itemCount: users.requireData.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0)
                          return Container();
                        else {
                          final int i = index - 1;
                          if (i == 0) //Primo posto
                            return _firstTile(
                                context, users.requireData[index]);
                          else if (i == 1) //Secondo posto
                            return _secondTile(
                                context, i, users.requireData[index]);
                          else if (i == 2) // Terzo posto
                            return _thirdTile(
                                context, i, users.requireData[index]);
                          else
                            return _rankingTile(
                                context, i, users.requireData[index]);
                        }
                      },
                    );
                  }
                  else {
                    child = SizedBox(key: ValueKey(1));
                  }
                  return AnimatedSwitcher(
                    child: child,
                    duration: Duration(milliseconds: 150),
                    reverseDuration: Duration(milliseconds: 150),
                  );
                }),
          ),
        );
      },
    );
  }

  Widget _firstTile(BuildContext context, FoodUser user) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.emoji_events_outlined,
                  size: 32, color: theme.maincolor)),
          Card(
            margin: EdgeInsets.zero,
            shape: cardShape,
            elevation: 20,
            child: Container(
              height: cardHeight + 10,
              width: width - 65,
              decoration: BoxDecoration(
                  gradient: theme.gradient, borderRadius: containerRadius),
              child: _podioTiles(user, Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondTile(BuildContext context, int i, FoodUser user) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                '${i + 1}°',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(2, 128, 144, 1),
                    fontWeight: FontWeight.w500),
              )),
          Card(
            margin: EdgeInsets.zero,
            shape: cardShape,
            elevation: 15,
            child: Container(
              height: cardHeight + 10,
              width: width - 70,
              decoration: BoxDecoration(
                  gradient: theme.gradientList[2],
                  borderRadius: containerRadius),
              child: _podioTiles(user, Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _thirdTile(BuildContext context, int i, FoodUser user) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                '${i + 1}°',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(250, 126, 30, 1),
                    fontWeight: FontWeight.w500),
              )),
          Card(
            margin: EdgeInsets.zero,
            shape: cardShape,
            elevation: 10,
            child: Container(
              height: cardHeight + 10,
              width: width - 75,
              decoration: BoxDecoration(
                  gradient: theme.gradientList[1],
                  borderRadius: containerRadius),
              child: _podioTiles(user, Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankingTile(BuildContext context, int i, FoodUser user) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '${i + 1}°',
                style: TextStyle(fontSize: 21),
              )),
          Card(
            margin: EdgeInsets.zero,
            shape: cardShape,
            elevation: 4,
            child: Container(
              height: cardHeight + 10,
              width: width - 75,
              decoration: BoxDecoration(borderRadius: containerRadius),
              child: _podioTiles(user),
            ),
          ),
        ],
      ),
    );
  }

  Widget _podioTiles(FoodUser user, [Color? color]) {
    return Container(
      padding: EdgeInsets.only(right: 10, bottom: 15, left: 10),
      child: ListTile(
        title: Text(user.fullName,
            style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        subtitle: Text(
          'LV.${user.level.toString()}',
          style: TextStyle(
              color: color, fontSize: 13, fontWeight: FontWeight.w500),
        ),
        trailing: Text(user.points.value.toString(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: color)),
      ),
    );
  }
}
