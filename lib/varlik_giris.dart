import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'models/rich-model.dart';

class VarlikGiris extends StatefulWidget {
  final String tipTitle;

  VarlikGiris(this.tipTitle);

  @override
  State<VarlikGiris> createState() => _VarlikGirisState();
}

class _VarlikGirisState extends State<VarlikGiris> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // inputun değerini okumak için
  final textFileldContoller = TextEditingController();
  // inputun değerini okumak için
  final birimMaliyetController = TextEditingController();
  double toplam = 0;

  @override
  void initState() {
    super.initState();

    // sayfa açıldığında varlık tipine göre toplam tutar alanını hesaplattıyoruz
    setState(() {
      var c = richModel
          .where((element) => element.varlikTipi == widget.tipTitle)
          .map((e) => e.tutar).toList();
      if (c.isNotEmpty && c.first != null) {
        toplam = c.reduce((value, element) => (value ?? 0) + (element ?? 0))!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Text(
            widget.tipTitle,
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Toplam " + toplam.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: textFileldContoller,
            keyboardType: TextInputType.number,
            maxLength: 20,
            decoration: const InputDecoration(
              labelText: 'Miktar',
              labelStyle: TextStyle(
                color: Color(0xFF6200EE),
              ),
            ),
          ),
          if (widget.tipTitle != "TL")
            TextFormField(
              controller: birimMaliyetController,
              keyboardType: TextInputType.number,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Birim Maliyet',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _girisMiktariniDegistir(false);
                  },
                  child: const Text('Çıkar')),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _girisMiktariniDegistir(true);
                  },
                  child: const Text('Ekle')),
            ],
          ),
        ],
      ),
    );
  }

  void _girisMiktariniDegistir(isEkle) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      // veri girişi yoksa işlem yapmıyourz
      if (textFileldContoller.text == "") {
        return;
      }
// girilen miktarı toplama eklemek için 1 ile çıkarmak için -1 ile çarpıyoruz
      RichModel temp = RichModel();
      temp.tutar = double.parse(textFileldContoller.text) * (isEkle ? 1 : -1);
      temp.varlikTipi = widget.tipTitle;
// döviz için birrim maliyet kısmı eklenir null olduğunda 1 girilir tl de gizlenir
      if (widget.tipTitle != "TL" && birimMaliyetController.text != "") {
        temp.birimMaliyet = double.parse(birimMaliyetController.text);
      } else {
        temp.birimMaliyet = 1;
      }
      richModel.add(temp);

      var c = richModel
          .where((element) => element.varlikTipi == widget.tipTitle)
          .map((e) => e.tutar).toList();
      if (c.isNotEmpty && c.first != null) {
        toplam = c.reduce((value, element) => (value ?? 0) + (element ?? 0))!;
      }

      textFileldContoller.text = "";
      if (widget.tipTitle != "TL") {
        birimMaliyetController.text = "";
      }
// klavyeyi kapatır
      FocusManager.instance.primaryFocus?.unfocus();
      prefs.setString("data",RichModel.encode(richModel));

      var mapTL = richModel
          .where((element) => element.varlikTipi == "TL")
          .map((e) => e.tutar).toList();

      if (mapTL.isNotEmpty ) {
        girisYapilanTopamTLTutar =  mapTL.reduce((value, element) => (value ?? 0) + (element ?? 0))!;
      }

      var mapDoviz = richModel
          .where((element) => element.varlikTipi != "TL")
          .map((e) => (e.tutar ?? 0) * (e.birimMaliyet ?? 1)).toList();
      if (mapDoviz.isNotEmpty ) {
        girisYapilanTopamDoviz =  mapDoviz.reduce((value, element) => (value ?? 0) + ((element ?? 0)))!;
      }

      var mapDovizSabitKur = richModel
          .where((element) => element.varlikTipi != "TL")
          .map((e) => (e.tutar ?? 0) * sabitKur).toList();
      if (mapDovizSabitKur.isNotEmpty ) {
        girisYapilanTopamSabitKurTutar =  mapDovizSabitKur.reduce((value, element) => (value ?? 0) + ((element ?? 0)))!;
      }

    });
  }
}
