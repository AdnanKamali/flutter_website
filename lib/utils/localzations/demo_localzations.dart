import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context) =>
      Localizations.of(context, DemoLocalizations);

  late Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle.loadString("language/fa.json");
    Map<String, dynamic> _result = jsonDecode(data);

    this._sentences = Map();
    _result.forEach((key, value) {
      this._sentences[key] = value.toString();
    });
    return true;
  }

  String translate(String key) {
    return this._sentences[key]!;
  }
}
