import 'package:athens/model/hero.dart';
import 'package:athens/screens/heroes/hero_card.dart';
import 'package:flutter/material.dart';

class ChooseHero extends StatelessWidget {
  const ChooseHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 16),
                Text("Choose your warrior!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    children: [
                      HeroCard(FoodHero('Pizza', 'Armed with spatula and cutter, the Pizza Warrior is a relentless defender of authentic pies.')),
                      SizedBox(height: 16),
                      HeroCard(FoodHero('Kebab', 'Clad in tinfoil armor, the Kebab Warrior skewers the ordinary, grilling up justice and sizzling spectacle in his quest for the ultimate skewer.')),
                      SizedBox(height: 16),
                      HeroCard(FoodHero('Pita', 'In the culinary arena of flatbreads, the Pita Warrior reigns supreme, skillfully pocketing adversaries while serving up a fresh dose of falafel-filled fortitude.')),
                      SizedBox(height: 16),
                      HeroCard(FoodHero('Fruit', 'Brandishing a banana blade, the Fruit Warrior jousts in a juicy jungle of vitamins, his armor polished to a citrus sheen.')),
                      SizedBox(height: 16),
                      HeroCard(FoodHero('Sushi', 'With a roll of his katana, the Sushi Warrior deftly slices through the mundane.')),
                    ],
                  )
                )
              ],
            )
          ),
        )
      ),
    );
  }
}
