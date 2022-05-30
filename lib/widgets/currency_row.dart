import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../models/series_data_class.dart';
import '../services/service.dart';
import '../varlik_giris.dart';

class CurrencyRow extends StatefulWidget {
  final String? code;
  final String? text;

  const CurrencyRow({this.code, this.text});

  @override
  _CurrencyRowState createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  SeriesData? data;

  getCurrency()  async {
    try {
      data = await getEVDSUpdatedCurrencies(widget.code!);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          widget.code!,
          style: GoogleFonts.roboto(
            color: Colors.teal[300],
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        data == null
            ? Text('-')
            : data == null || data!.value == null
                ? Text('-')
                : Text(
                    data!.value!.toStringAsFixed(2),
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo[300],
                      fontSize: 16.0,
                    ),
                  ),
        data == null
            ? Text('-')
            : data == null || data!.value == null
                ? Text('-')
                : Text(
                    data!.value!.toStringAsFixed(2),
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange[300],
                      fontSize: 16.0,
                    ),
                  ),
        ElevatedButton(
            onPressed: () {
    pushNewScreen(
    context,
    screen: VarlikGiris(widget.code!),
    withNavBar: false,
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: const Text('Ekle')),
      ],
    );
  }
}
