import 'package:athens/model/hero.dart';
import 'package:athens/screens/overview.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/skeleton/authentication.dart';
import 'package:athens/service/skeleton/database.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final FoodHero hero;

  HeroCard(this.hero);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () {
        Authentication.user.hero = hero.name;
        Database.update('users', Authentication.getAuthId(), {
          'hero': hero.name
        });
        Routing.moveToPage(context, Overview());
      },
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black)
        ),
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Image.asset(
                'assets/warriors/${hero.image}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hero.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 190,
                  child: Text(
                    hero.description
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
