import 'package:athens/screens/utils/loading_indicator.dart';
import 'package:flutter/material.dart';

class OverlayLoader {
  static BuildContext? lastContext;

  static bool isLoading = false;

  static void showLoading(BuildContext context) {
    isLoading = true;
    //Overlay.of(context)!.insert(_overlayEntry);
    lastContext = context;
    showDialog(context: context, builder: (context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark.withOpacity(0.3),
            body: SafeArea(
              child: Center(
                child: LoadingIndicator(),
              ),
            ),
          )
      );
    }, barrierDismissible: false, useSafeArea: false);
  }

  static void unshowLoading() {
    isLoading = false;
    Navigator.pop(lastContext!);
  }
}