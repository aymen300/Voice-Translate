import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mahdi_app/pages/figure.dart';
import 'package:mahdi_app/pages/game.dart';
import 'package:mahdi_app/pages/home.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("mahdi"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
           
          ],),
          SizedBox(
            child: Image.asset("assets/meteo.jpg"),
            height: 200,
            width: 200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your email",
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3, color: color), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
                onPressed: () {
                                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Game()),
              );
                  setState(() {
                    color = color == Colors.grey ? Colors.orange : Colors.grey;
                  });

                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.black),
                    ))),
                child: const Text("Login")),
          )
        ]),
      ),
    );
  }
}
