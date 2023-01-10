import 'dart:convert';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';
import 'package:voice_translate/pages/record_page.dart';
import 'package:voice_translate/service/database.dart';
import 'package:voice_translate/service/flutterfire.dart';
import 'package:voice_translate/service/text_to_speech_api.dart';
import 'package:voice_translate/service/translate_api.dart';

import '../service/speech_api.dart';
import '../widgets/Utils.dart';
import '../widgets/my_drawer.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});
  static String selectedLanguage = "";
  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final translator = GoogleTranslator();
  List<String> languages = ["English", "French", "Arabic"];
  List<String> codes = ["en", "fr", "ar"];
  late String dropDownValueFrom = languages[0];
  late String dropDownValueTo = languages[1];
  TextEditingController textToTranslate = TextEditingController();
  TextEditingController TranslatedText = TextEditingController();
  bool isListening = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  IconData icon = Icons.mic;
  String data = 'file';
  dynamic openFiles(List<PlatformFile> files) {
    dynamic result = '';
    TranslateAPI().translate(files[0], "en", "ar").then((value) {
      result = value;
    });

    setState(() {
      data = files[0].path!;
    });
    Column(
      children: [
        Container(), //your Container here
        // show(files: files), //here you insert your List
      ],
    );
    return result;
  }

  @override
  void initState() {
    TranslatorPage.selectedLanguage = dropDownValueFrom;
    setState(() {
      if (textToTranslate.text.isNotEmpty) {
        translator
            .translate(textToTranslate.text,
                from: codes[languages.indexOf(dropDownValueFrom)],
                to: codes[languages.indexOf(dropDownValueTo)])
            .then((tr) {
          setState(() {
            TranslatedText.text = tr.text;
          });
        });
      }
    });
    print(TranslatorPage.selectedLanguage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusScope.of(context).unfocus();
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 89, 86, 233),
          title: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text("Translator",
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 25,
                    fontWeight: FontWeight.w600)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset("assets/menu.png"),
                iconSize: 30),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton2(
                      style: const TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      /*buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color.fromARGB(255, 89, 86, 233),
                        ),
                      ),*/
                      buttonWidth: 132,
                      dropdownWidth: 132,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      underline: const SizedBox(),
                      value: dropDownValueFrom,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color.fromARGB(255, 89, 86, 233),
                      ),
                      iconOnClick: const Icon(Icons.keyboard_arrow_up,
                          color: Color.fromARGB(255, 89, 86, 233)),
                      items: languages.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          if (newValue == dropDownValueTo) {
                            String aux = dropDownValueFrom;
                            dropDownValueFrom = dropDownValueTo;
                            dropDownValueTo = aux;
                          } else {
                            dropDownValueFrom = newValue!;
                          }
                          TranslatorPage.selectedLanguage = dropDownValueFrom;
                          if (textToTranslate.text != "") {
                            translator
                              .translate(textToTranslate.text,
                                  from: codes[
                                      languages.indexOf(dropDownValueFrom)],
                                  to: codes[languages.indexOf(dropDownValueTo)])
                              .then((tr) {
                            setState(() {
                              TranslatedText.text = tr.text;
                            });
                            /*if (textToTranslate.text.isEmpty) {
                                  setState(() {
                                    TranslatedText.text = "";
                                  });
                                }*/
                          });
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    FloatingActionButton(
                        heroTag: "1",
                        backgroundColor: const Color.fromARGB(255, 89, 86, 233),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            String aux = dropDownValueFrom;
                            dropDownValueFrom = dropDownValueTo;
                            dropDownValueTo = aux;
                            TranslatorPage.selectedLanguage = dropDownValueFrom;
                            if (TranslatedText.text.isNotEmpty) {
                              textToTranslate.text = TranslatedText.text;
                              translator
                                  .translate(textToTranslate.text,
                                      from: codes[
                                          languages.indexOf(dropDownValueFrom)],
                                      to: codes[
                                          languages.indexOf(dropDownValueTo)])
                                  .then((tr) {
                                setState(() {
                                  TranslatedText.text = tr.text;
                                });
                                /*if (textToTranslate.text.isEmpty) {
                                  setState(() {
                                    TranslatedText.text = "";
                                  });
                                }*/
                              });
                            }
                          });
                        },
                        child: const Icon(
                          IconData(0xe182, fontFamily: 'MaterialIcons'),
                          size: 30,
                        )),
                    const SizedBox(width: 16),
                    DropdownButton2(
                      style: const TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      /*buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color.fromARGB(255, 89, 86, 233),
                        ),
                      ),*/
                      buttonWidth: 132,
                      dropdownWidth: 132,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      underline: const SizedBox(),
                      value: dropDownValueTo,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconOnClick: const Icon(Icons.keyboard_arrow_up),
                      items: languages.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          if (newValue == dropDownValueFrom) {
                            String aux = dropDownValueFrom;
                            dropDownValueFrom = dropDownValueTo;
                            dropDownValueTo = aux;
                          } else {
                            dropDownValueTo = newValue!;
                          }
                          if (textToTranslate.text != "") {
                            translator
                                .translate(textToTranslate.text,
                                    from: codes[
                                        languages.indexOf(dropDownValueFrom)],
                                    to: codes[
                                        languages.indexOf(dropDownValueTo)])
                                .then((tr) {
                              setState(() {
                                TranslatedText.text = tr.text;
                              });
                              /*if (textToTranslate.text.isEmpty) {
                                  setState(() {
                                    TranslatedText.text = "";
                                  });
                                }*/
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                child: Focus(
                  onFocusChange: (value) {
                    if (!value) {
                      if (textToTranslate.text != "") {
                        Map<String, dynamic> data = {};
                        DatabaseService(uid: getUid()).getData().then((value) {
                          data = value.data() as Map<String, dynamic>;
                          print(data['history']);
                          List<dynamic> history =
                              data['history'] as List<dynamic>;

                          (history).add({
                            "from": textToTranslate.text,
                            "to": TranslatedText.text,
                            "fromLan": dropDownValueFrom,
                            "toLan": dropDownValueTo
                          });

                          List<dynamic> jsonList =
                              history.map((item) => jsonEncode(item)).toList();
                          List<dynamic> uniqueJsonList =
                              jsonList.toSet().toList();
                          List<dynamic> result = uniqueJsonList
                              .map((item) => jsonDecode(item))
                              .toList();

                          print(result);

                          DatabaseService(uid: getUid()).updateHistory(result);
                        });
                      }
                      //print(data['history']);

                      //List<String> history = data['history'];
                      //history.add("k");
                      //DatabaseService(uid: getUid()).updateHistory(history);
                    }
                  },
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        translator
                            .translate(textToTranslate.text,
                                from:
                                    codes[languages.indexOf(dropDownValueFrom)],
                                to: codes[languages.indexOf(dropDownValueTo)])
                            .then((tr) {
                          setState(() {
                            TranslatedText.text = tr.text;
                          });
                          if (textToTranslate.text.isEmpty) {
                            setState(() {
                              TranslatedText.text = "";
                            });
                          }
                        });
                      }
                    },

                    onEditingComplete: () {},
                    controller: textToTranslate,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 89, 86, 233)),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 32),
                    ),
                    style: const TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    //initialValue:
                    //   "Maintenant, c'est l'histoire de la façon dont ma vie a été bouleversée, bouleversée et j'aimerais prendre une minute juste assis là.",
                    //controller: textToTranslate,
                    maxLines: null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                child: TextFormField(
                  controller: TranslatedText,
                  enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 89, 86, 233),
                      fontFamily: "Raleway",
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  //initialValue:
                  //    "Now this is the story all about how my life  got flipped, turned upside down And i’d like to take a minute just sit right there.",
                  maxLines: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/copy.png'),
                      onPressed: () async {
                        if (TranslatedText.text.isNotEmpty) {
                          await FlutterClipboard.copy(TranslatedText.text)
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Copied to clipboard")));
                          });
                        }
                      },
                    ),
                    // IconButton(
                    //   icon: Image.asset('assets/upload.png'),
                    //   onPressed: () async {
                    //     final result = await FilePicker.platform
                    //         .pickFiles(allowMultiple: true);
                    //     if (result == null) return;

                    //     String link = openFiles(result.files) as String;
                    //     print(link + "******************************");
                    //     setState(() {
                    //       TranslatedText.text = link;
                    //     });

                    //     /*await FlutterClipboard.copy(link.toString())
                    //         .then((_) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text("Copied to clipboard")));
                    //     });*/
                    //   },
                    // ),
                    IconButton(
                      icon: Image.asset('assets/like.png'),
                      onPressed: () {
                        if (textToTranslate.text.isNotEmpty) {
                          Map<String, dynamic> data = {};
                          DatabaseService(uid: getUid())
                              .getData()
                              .then((value) {
                            data = value.data() as Map<String, dynamic>;

                            List<dynamic> favorite =
                                data['favorite'] as List<dynamic>;

                            (favorite).add({
                              "from": textToTranslate.text,
                              "to": TranslatedText.text,
                              "fromLan": dropDownValueFrom,
                              "toLan": dropDownValueTo
                            });

                            List<dynamic> jsonList = favorite
                                .map((item) => jsonEncode(item))
                                .toList();
                            List<dynamic> uniqueJsonList =
                                jsonList.toSet().toList();
                            List<dynamic> result = uniqueJsonList
                                .map((item) => jsonDecode(item))
                                .toList();

                            print(result);

                            DatabaseService(uid: getUid())
                                .updateFavorite(result);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Translation added to Favorites.")));
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/voice.png'),
                      onPressed: () {
                        if (TranslatedText.text.isNotEmpty) {
                          TextToSpeechApi().speak(TranslatedText.text,
                              codes[languages.indexOf(dropDownValueTo)]);
                        }
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/delete.png'),
                      onPressed: () {
                        textToTranslate.text = "";
                        TranslatedText.text = "";
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AvatarGlow(
                  animate: isListening,
                  endRadius: 80,
                  glowColor: Theme.of(context).primaryColor,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: FloatingActionButton(
                      heroTag: "2",
                      backgroundColor: const Color.fromARGB(255, 89, 86, 233),
                      foregroundColor: Colors.white,

                      child: Icon(icon, size: 50),
                      //icon: Icon(Icons.stop),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecordPage()),
                        );*/
                        toggleRecording();
                        if (isListening == true) {
                          icon = Icons.stop_rounded;
                        } else {
                          icon = Icons.mic;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          //textToTranslate.text = text;
          textToTranslate.value = TextEditingValue(
            text: text,
          );
          if (textToTranslate.text.isNotEmpty) {
            translator
                .translate(textToTranslate.text,
                    from: codes[languages.indexOf(dropDownValueFrom)],
                    to: codes[languages.indexOf(dropDownValueTo)])
                .then((tr) {
              setState(() {
                TranslatedText.text = tr.text;
              });
            });
          }
        }),
        onListening: (isListening) {
          if (isListening == false) {
            setState(() => this.isListening = isListening);
          }
          setState(() {
            this.isListening = isListening;
          });

          /*if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(RecordPage.text);
            });
          }*/
        },
      );
}
