import 'package:flutter/material.dart';
import 'package:rich/widgets/currency_row.dart';

import 'constants/constants.dart';

class DovizListesi extends StatefulWidget {
  const DovizListesi({Key? key}) : super(key: key);

  @override
  State<DovizListesi> createState() => _DovizListesiState();
}

class _DovizListesiState extends State<DovizListesi> {
  @override
  Widget build(BuildContext context) {
    return buildCurrencyList(series);
  }

  buildCurrencyList(List<String> codes) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blueGrey[800],
        ),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              );
            },
            itemCount: codes.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: CurrencyRow(
                  code: codes[index],
                ),
              );
            }),
      ),
    );
  }
}
