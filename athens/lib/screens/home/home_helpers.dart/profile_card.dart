import "package:athens/constants/theme_model.dart";
import "package:athens/model/user.dart";
import "package:athens/service/skeleton/authentication.dart";
import "package:flutter/material.dart";

class ProfileCard extends StatelessWidget {
  final ShapeBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));
  final containerRadius = BorderRadius.all(Radius.circular(20));
  final ThemeModel theme = ThemeModel.instance;
  ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        margin: EdgeInsets.zero,
        shape: cardShape,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              gradient: theme.gradient, borderRadius: containerRadius),
          child: ListTile(
            leading: Authentication.user.hero.isEmpty ?
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 22,
              child: Icon(Icons.person),
            ) :
            SizedBox(
              height: 44,
              width: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/warriors/${Authentication.user.hero}.jpg',
                  fit: BoxFit.cover,
                )
              )
            ),
            title: Text(
              Authentication.user.fullName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
            ),
            subtitle: Text(
              'LV. ${Authentication.user.level.toString()}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            trailing: ValueListenableBuilder<int>(
              valueListenable: Authentication.user.points,
              builder: (context, points, child) {
                return Text(points.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white));
              }
            ),
          ),
        ),
      ),
    );
  }
}
