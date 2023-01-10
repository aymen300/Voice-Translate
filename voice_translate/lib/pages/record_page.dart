import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:voice_translate/pages/translator_page.dart';

import '../widgets/Utils.dart';
import '../service/speech_api.dart';
import '../widgets/substring_highlighted.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  static String text = "";
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isListening = false;
  IconData icon = Icons.content_copy;

  @override
  void initState() {
    super.initState();
    RecordPage.text = 'Press the button and start speaking';
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 86, 233),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text("Recording",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 25,
                  fontWeight: FontWeight.w600)),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FlutterClipboard.copy(RecordPage.text);
                setState(() {
                  icon = Icons.done;
                });
              },
              icon: Icon(icon),
              iconSize: 25),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Record",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 50,
                    fontWeight: FontWeight.w900)),
            Text(RecordPage.text),
            SubstringHighlight(
              text: RecordPage.text,
              terms: Command.all,
              textStyle: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textStyleHighlight: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            AvatarGlow(
              animate: isListening,
              endRadius: 75,
              glowColor: Theme.of(context).primaryColor,
              child: SizedBox(
                width: 90,
                height: 90,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 89, 86, 233),
                  foregroundColor: Colors.white,
                  onPressed: toggleRecording,

                  /*setState(() {
                        if (icon == Icons.play_arrow_rounded) {
                          icon = Icons.pause;
                        } else {
                          icon = Icons.play_arrow_rounded;
                        }
                      });
                      
                      print(text);
                    },*/
                  child: Icon(
                      isListening ? Icons.pause : Icons.play_arrow_rounded,
                      size: 50),
                ),
              ),
            ),
            GestureDetector(
              child: Text("translate"),
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TranslatorPage()),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          RecordPage.text = text;
        }),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(RecordPage.text);
            });
          }
        },
      );
}
