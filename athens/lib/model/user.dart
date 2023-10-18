import 'package:athens/service/skeleton/authentication.dart';
import 'package:athens/service/skeleton/database.dart';
import 'package:flutter/cupertino.dart';

class FoodUser {
  String fullName = '';
  String publicKey = '';
  ValueNotifier<int> points = ValueNotifier(0);
  int level = 1;
  String hero = '';

  FoodUser();
  FoodUser.fromMap(Map<String, dynamic> userMap) {
    fullName = userMap['full_name'];
    points.value = userMap['points'];
    if (userMap.containsKey('hero')) {
      hero = userMap['hero'];
    }
  }

  Future<void> init() async {
    try {
      if (Authentication.isLoggedIn()) {
        print(Authentication.getAuthId());
        final userData = await Database.get('users', Authentication.getAuthId());

        fullName = userData['full_name'];
        points.value = userData['points'];
        level = userData['level'];
        if (userData.containsKey('public_key')) {
          publicKey = userData['public_key'];
        }
        if (userData.containsKey('hero')) {
          hero = userData['hero'];
        }
      }
    } catch(ignored) {
    }
  }

  Future<void> create(String name) async {
    await Database.post('users', Authentication.getAuthId(), {
      'full_name': name,
      'points': 0,
      'level': 1,
    });
    fullName = name;
  }
}