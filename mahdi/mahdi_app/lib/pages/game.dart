import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Color> colors = [Colors.red, Colors.blue, Colors.yellow, Colors.black];
  int a = Random().nextInt(4);
  int b = Random().nextInt(4);
  int c = Random().nextInt(4);
  int d = Random().nextInt(4);
  dynamic alert() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Congrats",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ));
  }

  @override
  void initState() {
    if ((a == b) && (b == c) && (c == d)) {
      print("Congrats");
      alert();
    }
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
                child: Text(
              "Colors Game",
              style: TextStyle(color: Colors.purple, fontSize: 50),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      a = Random().nextInt(4);
                    });
                    if ((a == b) && (b == c) && (c == d)) {
                      print("Congrats");
                      alert();
                    }
                  },
                  child: Ink(height: 50, width: 50, color: colors[a]),
                ),
                SizedBox(width: 30),
                InkWell(
                    onTap: () {
                      setState(() {
                        b = Random().nextInt(4);
                      });
                      if ((a == b) && (b == c) && (c == d)) {
                        print("Congrats");
                        alert();
                      }
                    },
                    child: Ink(height: 50, width: 50, color: colors[b])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        c = Random().nextInt(4);
                      });
                      if ((a == b) && (b == c) && (c == d)) {
                        print("Congrats");
                        alert();
                      }
                    },
                    child: Ink(height: 50, width: 50, color: colors[c])),
                SizedBox(width: 30),
                InkWell(
                    onTap: () {
                      setState(() {
                        d = Random().nextInt(4);
                      });
                      if ((a == b) && (b == c) && (c == d)) {
                        print("Congrats");
                        alert();
                      }
                    },
                    child: Ink(height: 50, width: 50, color: colors[d])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ElevatedButton(
                onPressed: () {
                  a = Random().nextInt(4);
                  b = Random().nextInt(4);
                  c = Random().nextInt(4);
                  d = Random().nextInt(4);
                  setState(() {});
                  if ((a == b) && (b == c) && (c == d)) {
                    print("Congrats");
                    alert();
                  }
                },
                child: Text("reset game")),
          )
        ]),
      ),
    );
  }
}
