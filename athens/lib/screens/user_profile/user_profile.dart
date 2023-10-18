import 'package:athens/screens/authentication/login_page.dart';
import 'package:athens/screens/user_profile/send_tokens.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/overlay_loader.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:athens/service/skeleton/authentication.dart';
import 'package:athens/service/skeleton/blockchain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/theme_model.dart';

class UserProfile extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;
  final containerRadius = BorderRadius.all(Radius.circular(20));
  UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 8, bottom: 128),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/warriors/${Authentication.user.hero}.jpg',
                  fit: BoxFit.cover,
                )
              )
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
          child: Text(
            'YOUR IMPACT ON FOOD WASTE',
            style: TextStyle(
              fontSize: 18,
              color: theme.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.currency_bitcoin_outlined,
                            size: 36, color: Colors.white),
                        SizedBox(height: 5),
                        FutureBuilder<double>(
                          future: Blockchain.getBalanceOfSelf(),
                          builder: (context, balance) {
                            Widget child;
                            if (balance.hasData) {
                              child = Text(
                                key: ValueKey(0),
                                balance.requireData.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  )
                              );
                            }
                            else {
                              child = Text('', key: ValueKey(1));
                            }
                            return AnimatedSwitcher(
                              duration: Duration(milliseconds: 100),
                              reverseDuration: Duration(milliseconds: 100),
                              child: child
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events_outlined,
                            size: 36, color: Colors.white),
                        SizedBox(height: 5),
                        ValueListenableBuilder<int>(
                          valueListenable: Authentication.user.points,
                          builder: (context, points, child) {
                            return Text(
                              points.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.settings_outlined, color: Colors.black),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 20),
              ),
              ListTile(
                leading: Icon(Icons.store_outlined, color: Colors.black),
                title: Text('Orders'),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 20),
              ),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.black),
                title: Text('Help Center'),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 20),
              ),
              Clickable(
                onTap: () async {
                  OverlayLoader.showLoading(context);
                  try {
                    await Authentication().signOut();
                    OverlayLoader.unshowLoading();
                    Routing.moveToPage(context, LoginPage());
                  } catch(e) {
                    OverlayLoader.unshowLoading();
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.black),
                  title: Text('Log Out'),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 20),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            'TRANSFER YOUR COINS',
            style: TextStyle(
              fontSize: 18,
              color: theme.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 175,
                child: ElevatedButton(
                    onPressed: () =>
                        Routing.slideToPage(context, SendTokens()),
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
                      'Send',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    )),
              ),
              Container(
                height: 50,
                width: 175,
                child: ElevatedButton(
                    onPressed: () => _showMyDialog(context),
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
                      'Receive',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Receive Tokens'),
          content: Text(Authentication.user.publicKey),
          actions: <Widget>[
            TextButton(
              child: Text('Copy Address',
                  style: TextStyle(color: theme.maincolor)),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: Authentication.user.publicKey));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
