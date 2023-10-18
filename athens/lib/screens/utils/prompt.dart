import 'package:athens/screens/utils/dialogue_prompt.dart';
import 'package:flutter/material.dart';

class Prompt {
  static OverlayEntry _dialogueBox = OverlayEntry(
    builder: (context) {
      return SizedBox(

      );
    }
  );

  static bool overlay = false;

  static void remove(BuildContext context) {
    _dialogueBox.remove();
    overlay = false;
  }

  static void dialogue(BuildContext context, String title, {String? description, bool multiChoice = false, void Function()? onConfirm, String buttonText = 'Ok', String? cancelButtonText, bool green = false, bool red = false}) async {
    String cancelText = cancelButtonText == null ? 'Cancel' : cancelButtonText;
    showDialog(context: context, builder: (context) {
      return DialoguePrompt(title, buttonText, cancelText, description: description, multiChoice: multiChoice, onConfirm: onConfirm, onCancel: () {
      }, green: green, red: red);
    }, useSafeArea: false);
    //overlay = true;
    return;
  }
}


