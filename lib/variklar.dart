import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rich/varlik_giris.dart';

import 'doviz_listesi.dart';

class Varliklar extends StatefulWidget {
  const Varliklar({Key? key}) : super(key: key);

  @override
  State<Varliklar> createState() => _VarliklarState();
}

class _VarliklarState extends State<Varliklar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.money_rounded),
            title: const Text('Türk Lirası'),
            onTap: () {
              pushNewScreen(
                context,
                screen: VarlikGiris("TL"),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.money_rounded),
            title: const Text('Döviz'),
            onTap: () {
               pushNewScreen(
                context,
                screen: const DovizListesi(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      ),
    );
  }
}
