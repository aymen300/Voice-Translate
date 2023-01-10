import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_translate/pages/login_page.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/emailNotification.png",
            width: 500,
            height: 400,
          ),
          Text("Confirm your email address",
              style: TextStyle(
                  fontFamily: 'Rale',
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade800)),
          const Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Text("Confirmation email has been sent to:",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Text(user.email!,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700)),
           Padding(
            padding: const EdgeInsets.only(top: 32.0,left:8,right:8),
            child: Text(
                "Click on the link in the email to activate your account.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Rale',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }
}
