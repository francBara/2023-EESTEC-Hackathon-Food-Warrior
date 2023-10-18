import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final void Function() onTap;

  final ValueNotifier<bool> isPressedNotifier = ValueNotifier<bool>(false);

  final bool feedbackVisible;

  Clickable(
      {required this.onTap, required this.child, this.feedbackVisible = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (feedbackVisible) {
            isPressedNotifier.value = false;
          }
          onTap();
        },
        onTapDown: (TapDownDetails tapDownDetails) {
          if (feedbackVisible) {
            isPressedNotifier.value = true;
          }
        },
        onTapCancel: () {
          if (feedbackVisible) {
            isPressedNotifier.value = false;
          }
        },
        child: ValueListenableBuilder<bool>(
            valueListenable: isPressedNotifier,
            builder: (context, isPressed, builderChild) {
              return AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeOut,
                  opacity: isPressed ? 0.6 : 1,
                  child: builderChild);
            },
            child: child));
  }
}
