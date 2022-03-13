import 'package:flutter/material.dart';

class Language {
  final String name;
  final Icon icon;

  Language(this.name, this.icon);

  static List<Language> getlanguages() {
    return <Language>[
      Language('English', Icon(Icons.language)),
      Language('swahili', Icon(Icons.language)),
    ];
  }
}
