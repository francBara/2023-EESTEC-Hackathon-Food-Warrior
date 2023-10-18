import 'package:athens/model/food.dart';
import 'package:athens/model/utils/athens_strings.dart';
import 'package:athens/screens/food/food_card.dart';
import 'package:athens/screens/order/order_success.dart';
import 'package:athens/screens/unlock_wallet_screen.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/overlay_loader.dart';
import 'package:athens/screens/utils/prompt.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/food_service.dart';
import 'package:athens/service/skeleton/blockchain.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_model.dart';

class FoodOrder extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;

  final Food food;

  FoodOrder(this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: SafeArea(
          child: Column(
        children: [
          IgnorePointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              height: 240,
              child: FoodCard(food),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            alignment: Alignment.centerLeft,
            child: Text('Order recap - ${food.restaurant!.name}',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 4,
                  decoration: BoxDecoration(
                      color: theme.maincolor,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text('On ',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Container(
                      child: Text(food.restaurant!.road,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(food.name,
                      style: TextStyle(
                          fontSize: 16,
                          color: theme.secondaryColor,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text('You can take it today from 12:00 to 14:00',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Clickable(
            onTap: () async {
              try {
                OverlayLoader.showLoading(context);
                final res = await FoodService.buyFood(food, false);
                OverlayLoader.unshowLoading();
                Routing.slideToPage(context, OrderSuccess(res));
              } catch (e) {
                OverlayLoader.unshowLoading();
                print(e);
              }
            },
            child: Container(
              height: 55,
              width: 250,
              child: IgnorePointer(
                child: ElevatedButton(
                    onPressed: () {},
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
                      'Order now for ${AthensStrings.centsToString(food.price)}€',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    )),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            alignment: Alignment.center,
            height: 55,
            width: 250,
            child: Clickable(
              onTap: () async {
                if (Blockchain.credentials == null) {
                  Routing.slideToPage(context, UnlockWalletScreen(onUnlocked: () async {
                    Navigator.pop(context);
                    try {
                      OverlayLoader.showLoading(context);
                      await Blockchain.sendTokensTo(food.restaurant!.publicKey, double.parse(food.price.toString()));
                      final res = await FoodService.buyFood(food, true);
                      OverlayLoader.unshowLoading();
                      Routing.slideToPage(context, OrderSuccess(res));
                    } catch (e) {
                      OverlayLoader.unshowLoading();
                      Prompt.dialogue(context, 'You don\'t have enough tokens!');
                      print(e);
                    }
                  }));
                }
                try {
                  OverlayLoader.showLoading(context);
                  await Blockchain.sendTokensTo(food.restaurant!.publicKey, double.parse(food.price.toString()));
                  final res = await FoodService.buyFood(food, true);
                  OverlayLoader.unshowLoading();
                  Routing.slideToPage(context, OrderSuccess(res));
                } catch (e) {
                  OverlayLoader.unshowLoading();
                  //TODO: Display error to the user
                  print(e);
                }
              },
              child: Text(
                'Or buy with ${food.price} coins',
                key: ValueKey(0),
                style: TextStyle(
                    color: theme.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
