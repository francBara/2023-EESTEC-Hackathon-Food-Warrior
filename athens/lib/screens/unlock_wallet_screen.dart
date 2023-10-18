import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/overlay_loader.dart';
import 'package:athens/screens/utils/prompt.dart';
import 'package:athens/service/skeleton/blockchain.dart';
import 'package:flutter/material.dart';

import '../constants/theme_model.dart';

class UnlockWalletScreen extends StatefulWidget {
  final void Function() onUnlocked;
  UnlockWalletScreen({required this.onUnlocked});

  @override
  State<UnlockWalletScreen> createState() => _UnlockWalletScreenState();
}

class _UnlockWalletScreenState extends State<UnlockWalletScreen> {
  final ThemeModel theme = ThemeModel.instance;

  late String password;

  @override
  void initState() {
    password = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unlock your wallet')),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Your password',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty)
                    return 'Enter a valid password';
                  else
                    return null;
                },
                onChanged: (String p) {
                  this.password = p;
                },
                onSaved: (String? value) => this.password = value!,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 55,
              width: 250,
              child: Clickable(
                onTap: () async {
                  try {
                    OverlayLoader.showLoading(context);
                    await Blockchain.unlockWallet(password);
                    OverlayLoader.unshowLoading();
                    widget.onUnlocked();
                  } catch (e) {
                    OverlayLoader.unshowLoading();
                    Prompt.dialogue(context, 'Wrong password');
                  }
                },
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
                        'Confirm with password',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
