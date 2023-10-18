import 'package:athens/screens/utils/clickable.dart';
import 'package:athens/service/skeleton/blockchain.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Clickable(
          onTap: test,
            child: Text('Sandbox')
        ),
      ),
    );
  }
}

Future<void> test() async {
  await Blockchain.generatePrivateKey("aaaa");
  print(await Blockchain.credentials!.address.hex);
  // print(await Blockchain.getBalanceOfSelf());
}
