import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Indicator(),
    );
  }
}

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator();
    }
    return CircularProgressIndicator(
      strokeWidth: 0,
      color: Colors.transparent,
      backgroundColor: Colors.transparent,
      value: 0,
    );
  }
}
