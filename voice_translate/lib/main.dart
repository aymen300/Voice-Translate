
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:voice_translate/pages/register_page.dart';
import 'package:voice_translate/pages/translator_page.dart';
import 'package:voice_translate/pages/verify_page.dart';

import 'pages/login_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(const VoiceTranslateApp());
}

class VoiceTranslateApp extends StatelessWidget {
  const VoiceTranslateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
