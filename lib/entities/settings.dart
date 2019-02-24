/*
*
* Entity representing settings
*
*/

import 'dart:convert';

Settings settingsFromJson(String str) {
  final jsonData = json.decode(str);
  return Settings.fromJson(jsonData);
}

String settingsToJson(Settings data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Settings {
  int id;
  String language;
  String currency;
  String backup;

  Settings(
      {this.id,
      this.language,
      this.currency,
      this.backup});

  factory Settings.fromJson(Map<String, dynamic> json) => new Settings(
      id: json["id"],
      language: json["language"],
      currency: json["currency"],
      backup: json["backup"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "currency": currency,
        "backup": backup
      };
}
