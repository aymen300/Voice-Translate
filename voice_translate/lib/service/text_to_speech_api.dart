import 'dart:convert';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechApi{
  speak(String text, String languageCode) async {
    FlutterTts flutterTts=FlutterTts();
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);

}
}
