import 'dart:io';
import 'package:flutter/cupertino.dart';

class Routing {
  static Future<void> slideToPage(BuildContext context, Widget target,
      {dynamic arguments}) async {
    if (Platform.isIOS) {
      await Navigator.of(context, rootNavigator: true)
          .push(CupertinoPageRoute(builder: (context) {
        return target;
      }));
    } else {
      await Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (BuildContext context,
              Animation<double> firstAnimation,
              Animation<double> secondAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                  parent: firstAnimation,
                  curve: Curves.easeOutSine,
                  reverseCurve: Curves.easeOutSine.flipped)),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> firstAnimation,
              Animation<double> secondAnimation) {
            return target;
          },
          settings: RouteSettings(
            arguments: arguments,
          )));
    }
  }

  static Future<void> moveToPage(BuildContext context, Widget target, {dynamic arguments}) async {
    if (Platform.isIOS) {
      await Navigator.of(context, rootNavigator: true).pushReplacement(CupertinoPageRoute(builder: (context) {
        return target;
      }));
    } else {
      await Navigator.of(context, rootNavigator: true).pushReplacement(PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (BuildContext context,
              Animation<double> firstAnimation,
              Animation<double> secondAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                  parent: firstAnimation,
                  curve: Curves.easeOutSine,
                  reverseCurve: Curves.easeOutSine.flipped)),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> firstAnimation,
              Animation<double> secondAnimation) {
            return target;
          },
          settings: RouteSettings(
            arguments: arguments,
          )));
    }
  }

  static void fadeReplace(BuildContext context, Widget target) {
    Navigator.pushReplacement(context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (BuildContext context, Animation<double> firstAnimation, Animation<double> secondAnimation, Widget child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(CurvedAnimation(
                  parent: firstAnimation,
                  curve: Curves.easeOut
              )),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> firstAnimation, Animation<double> secondAnimation) {
            return target;
          },
        )
    );
  }
}
