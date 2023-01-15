import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_translate/pages/translator_page.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
   
    if (_speech.isListening) {
      
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );
    List<LocaleName> locales = await _speech.locales();

    var list = [];
    for (LocaleName localeName in locales) {
      list.add(localeName.name);
    }
    print(list);
    
    
    
    String selectedLanguage = TranslatorPage.selectedLanguage;
    print(selectedLanguage);

    if (isAvailable) {
      if (selectedLanguage == "English") {
        int english = list.indexOf("English (United States)");
        _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          localeId: locales[english].localeId,
        );
      }
      if (selectedLanguage == "French") {
        int french = list.indexOf("French (France)");
        _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          localeId: locales[french].localeId,
        );
      }
      if (selectedLanguage == "Arabic") {
        int arabic = list.indexOf("Arabic (Tunisia)");
        _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          localeId: locales[arabic].localeId,
        );
      }
      if (selectedLanguage == "Detect") {
        
        _speech.listen(
          onResult: (value) => onResult(value.recognizedWords),
          
        );
      }
      
    }

    return isAvailable;
  }
}
