import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:voice_translate/service/flutterfire.dart';
import 'package:voice_translate/widgets/my_drawer.dart';

import '../service/database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> data = {};
  List<dynamic> history = [];
  Map<String, dynamic> element = {};
  @override
  void initState() {
    DatabaseService(uid: getUid()).getData().then((value) {
      setState(() {
        data = value.data() as Map<String, dynamic>;
        history = data['history'] as List<dynamic>;

        //print(element["to"]);
        //print(history.length);
      });
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 89, 86, 233),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text("History",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 25,
                  fontWeight: FontWeight.w600)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: Image.asset("assets/menu.png"),
              iconSize: 30),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, position) {
          
          return GestureDetector(
            onTap: () {
              print(getElement(position, history));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    "${getElement(position, history)["fromLan"]}→${getElement(position, history)["toLan"]}\n\n",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    ' ${getElement(position, history)["from"]}\n',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 89, 86, 233),
                                    fontSize: 20)),
                            TextSpan(
                                text: ' ${getElement(position, history)["to"]}',
                                style:
                                    const TextStyle(color: Colors.black, fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          history
                              .remove(history[history.length - position - 1]);
                          DatabaseService(uid: getUid()).updateHistory(history);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 89, 86, 233),
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),

      /*ElevatedButton(
        child: Text("hi"),
        onPressed: (){
          print("helllo");
          DatabaseService(uid: getUid()).getData().then((value){
           Map<String,dynamic> data= value.data() as Map<String,dynamic>;
           List<dynamic> history=data['history'] as List<dynamic>;
           Map<String,dynamic> element=history[1] as Map<String,dynamic>;
           print(element["to"]);
          });
        },

      ),*/
    );
  }
}

Map<String, String> getElement(int index, List<dynamic> list) {
  list = List.from(list.reversed);
  dynamic element = list[index];
  Map<String, String> mapElement = {};
  mapElement["fromLan"] = element["fromLan"].toString();
  mapElement["toLan"] = element["toLan"].toString();
  mapElement["from"] = element["from"].toString();
  mapElement["to"] = element["to"].toString();

  return mapElement;
}
