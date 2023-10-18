import 'package:athens/screens/overview.dart';
import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/screens/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/theme_model.dart';

class OrderSuccess extends StatelessWidget {
  final ThemeModel theme = ThemeModel.instance;
  final String res;

  OrderSuccess(this.res);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Order Successful!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for your order. Your order has been successfully completed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 12),
            Clickable(
              onTap: () async {
                try {
                  launchUrlString(res);
                } catch(e) {

                }
              },
              child: Text(
                'Click here to see the tx of your reward',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Routing.slideToPage(context, Overview()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.maincolor,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                child: Text('Back to Home', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
