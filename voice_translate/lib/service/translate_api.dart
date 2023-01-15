import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;




class TranslateAPI {
  
  Future translate(PlatformFile q, String source, String target) async {
   var request = new http.MultipartRequest("POST", Uri.parse("https://libretranslate.de/translate_file"));
request.fields['source'] = 'en';
request.fields['target'] = 'ar';
request.files.add(await http.MultipartFile.fromPath(
    'file',
    q.path!,   ));
request.send().then((response) async {
  if (response.statusCode == 200) {return await response.stream.bytesToString();}
  else print( 'failed');
}

);
    
  }
}
