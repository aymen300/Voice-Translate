import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:voice_translate/service/translate_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FileManagerController controller = FileManagerController();

String data='file';

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
    body: Column(
      children: [
        Container(
          child: ElevatedButton(
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(allowMultiple:true);
              if (result == null) return;
              openFiles(result.files);
            },
            child: const Text("pick file"),
          ),
        ),
        Text(data),
      ],
    ),
  );
  }

     void openFiles(List<PlatformFile> files) {
      TranslateAPI().translate(files[0],"en","ar");
      setState((){data=files[0].path!;});
      Column(
  children: [
    Container(), //your Container here
   // show(files: files), //here you insert your List
  ],
);
      }
}
  
