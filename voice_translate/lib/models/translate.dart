// To parse this JSON data, do
//
//     final translate = translateFromJson(jsonString);

import 'dart:convert';

Translate translateFromJson(String str) => Translate.fromJson(json.decode(str));

String translateToJson(Translate data) => json.encode(data.toJson());

class Translate {
    Translate({
        required this.translatedText,
    });

    String translatedText;

    factory Translate.fromJson(Map<String, dynamic> json) => Translate(
        translatedText: json["translatedText"],
    );

    Map<String, dynamic> toJson() => {
        "translatedText": translatedText,
    };
}
