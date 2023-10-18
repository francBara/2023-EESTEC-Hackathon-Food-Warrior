import 'package:athens/screens/utils/clickable.dart';
import 'package:flutter/material.dart';

class DialoguePrompt extends StatelessWidget {
  String title;
  String buttonText;
  String cancelButtonText;
  String? description;
  bool multiChoice;
  bool green;
  bool red;

  void Function()? onConfirm;
  final void Function() onCancel;

  DialoguePrompt(this.title, this.buttonText, this.cancelButtonText, {this.description, this.onConfirm, required this.onCancel, this.multiChoice = false, this.green = false, this.red = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).primaryColorLight
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),
                  description != null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          description!,
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ) : SizedBox(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      multiChoice ?
                      Expanded(
                        child: Clickable(
                          onTap: () {
                            onCancel();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                              color: Theme.of(context).disabledColor
                            ),
                            child: Center(
                              child: Text(
                                cancelButtonText,
                                style: TextStyle(color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ),
                        ),
                      ) : SizedBox(),
                      Expanded(
                        child: Clickable(
                          onTap: () {
                            if (onConfirm != null) {
                              onConfirm!();
                            }
                            else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: multiChoice ? Radius.zero : Radius.circular(5)),
                              color: green ? Theme.of(context).hintColor : red ? Theme.of(context).errorColor : Theme.of(context).disabledColor
                            ),
                            child: Center(
                              child: Text(
                                buttonText,
                                style: TextStyle(color: green || red ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark),
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
