import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../constants/theme_model.dart';

class InviteFriendsCard extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;
  final containerRadius = BorderRadius.all(Radius.circular(26));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      height: 150,
      child: GestureDetector(
        onTap: () async => await _inviteFriends(),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                gradient: theme.gradientList[5], borderRadius: containerRadius),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "👋 Invite a friend",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, right: 20),
                      child: Icon(
                        Icons.ios_share_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                    'With your friends you can have a bigger impact!',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _inviteFriends() async {
    await FlutterShare.share(
        title: 'Share the word!',
        text: 'With your friends you can have a bigger impact!',
        chooserTitle: 'Share the word!'
    );
  }
}
