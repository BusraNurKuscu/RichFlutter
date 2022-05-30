import 'dart:convert';

class RichModel {
  String? varlikTipi = "TL";
  double? tutar = 0;
  double? birimMaliyet = 0;

  RichModel({ this.varlikTipi,  this.birimMaliyet,  this.tutar});

  factory RichModel.fromJson(Map<String, dynamic> jsonData) {
    return RichModel(
      varlikTipi: jsonData['varlikTipi'],
      tutar: jsonData['tutar'],
      birimMaliyet: jsonData['birimMaliyet'],
    );
  }

  static String encode(List<RichModel> model) => json.encode(
    model
        .map<Map<String, dynamic>>((model) => RichModel.toMap(model))
        .toList(),
  );

  static Map<String, dynamic> toMap(RichModel model) => {
    'varlikTipi': model.varlikTipi,
    'tutar': model.tutar,
    'birimMaliyet': model.birimMaliyet,
  };

  static List<RichModel> decode(String model) =>
      (json.decode(model) as List<dynamic>)
          .map<RichModel>((item) => RichModel.fromJson(item))
          .toList();
}
