import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_translate/pages/history_page.dart';
import 'package:voice_translate/pages/translator_page.dart';
import 'package:voice_translate/service/flutterfire.dart';

import '../pages/favorite_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 89, 86, 233),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child:
              SizedBox(width: 110, child: Image.asset("assets/halfCircle.png")),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 250, top: 20),
          child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset("assets/purpleEllipse.png")),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 16),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 89, 86, 233)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              icon: Icon(Icons.person_outline, size: 30),
              label: const Text(
                "Profile",
                style: TextStyle(
                    fontFamily: "Rale",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, left: 16),
          child: Divider(
            thickness: .3, // thickness of the line
            indent: 40, // empty space to the leading edge of divider.
            endIndent: 134, // empty space to the trailing edge of the divider.
            color: Colors.white, // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 89, 86, 233)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TranslatorPage()),
                );
              },
              icon: const Icon(Icons.translate, size: 30),
              label: const Text(
                "Translator",
                style: TextStyle(
                    fontFamily: "Rale",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, left: 16),
          child: Divider(
            thickness: .3, // thickness of the line
            indent: 40, // empty space to the leading edge of divider.
            endIndent: 134, // empty space to the trailing edge of the divider.
            color: Colors.white, // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 89, 86, 233)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
              icon: const Icon(Icons.history, size: 30),
              label: const Text(
                "History",
                style: TextStyle(
                    fontFamily: "Rale",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              )),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, left: 16),
          child: Divider(
            thickness: .3, // thickness of the line
            indent: 40, // empty space to the leading edge of divider.
            endIndent: 134, // empty space to the trailing edge of the divider.
            color: Colors.white, // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 89, 86, 233)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                );
              },
              icon: Icon(Icons.favorite_border_outlined, size: 30),
              label: const Text(
                "Favorites",
                style: TextStyle(
                    fontFamily: "Rale",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 180, top: 50),
          child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset("assets/purpleEllipse.png")),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 30),
          child: SizedBox(width: 100, child: Image.asset("assets/circle.png")),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 56),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 89, 86, 233)),
              ),
              onPressed: () {
                signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: Icon(
                IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                size: 30,
              ),
              label: const Text(
                "Sign out",
                style: TextStyle(
                    fontFamily: "Rale",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              )),
        ),
      ]),
    );
  }
}
