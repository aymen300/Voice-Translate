import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:voice_translate/pages/password_reset_page.dart';
import 'package:voice_translate/pages/register_page.dart';
import 'package:voice_translate/pages/translator_page.dart';
import 'package:voice_translate/widgets/alert_box.dart';

import '../service/flutterfire.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String passwordState = "Show";
  bool validEmail = true;
  bool validPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 89, 86, 233),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Positioned(
                top: MediaQuery.of(context).viewPadding.top - 26,
                left: 265,
                child: Image.asset(
                  "assets/pinkEllipse.png",
                  width: 125,
                  height: 125,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 12),
                child: Image.asset(
                  "assets/Rectangle.png",
                  width: 400,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 89, top: 26),
                child: Image.asset(
                  "assets/purpleEllipse.png",
                  width: 27,
                  height: 27,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 28, top: 85),
                child: Text(
                  """Welcome
back""",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 58,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 329, top: 215),
                child: Image.asset(
                  "assets/bigPurpleEllipse.png",
                  width: 35,
                  height: 35,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.66,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 36, left: 48),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, top: 32),
                        child: Row(
                          children: [
                            Image.asset("assets/Message.png"),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: 'Rale',
                                fontSize: 17,
                                color: Color.fromARGB(255, 134, 134, 134),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, right: 48),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                EmailValidator.validate(value) == false) {
                              validEmail = false;
                              return "Enter a valid Email please.";
                            } else {
                              validEmail =
                                  true & EmailValidator.validate(value);
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(
                              fontFamily: "Rale",
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 89, 86, 233)),
                            ),
                          ),
                          cursorColor: const Color.fromARGB(255, 89, 86, 233),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Rale",
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, top: 40),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/Lock.png",
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontFamily: 'Rale',
                                fontSize: 17,
                                color: Color.fromARGB(255, 134, 134, 134),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, right: 48),
                        child: TextFormField(
                          
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              validPassword = false;
                              return "Enter a valid Password please.";
                            } else {
                              validPassword = true;
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (passwordState == "Show") {
                                    passwordState = "Hide";
                                    isObscure = false;
                                  } else {
                                    passwordState = "Show";
                                    isObscure = true;
                                  }
                                });
                              },
                              child: Text(passwordState,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 89, 86, 233),
                                    fontFamily: "Rale",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            hintText: "Enter your Password",
                            hintStyle: const TextStyle(
                              fontFamily: "Rale",
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 89, 86, 233)),
                            ),
                          ),
                          cursorColor: const Color.fromARGB(255, 89, 86, 233),
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Rale",
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 48, top: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordResetPage()),
                            );
                          },
                          child: const Text("Forgot password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 89, 86, 233),
                                fontFamily: "Rale",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(
                          child: SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * .75,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                   
                                });
                                _formKey.currentState!.validate();
                                await signIn(emailController.text,
                                        passwordController.text)
                                    .then((value) {
                                  if (value == "success") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TranslatorPage()),
                                    );
                                  } else {
                                    {
                                      alertBoxDetail(context, "Failed",
                                          value.substring(30));
                                    }
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 89, 86, 233),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15), // <-- Radius
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Rale',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                              );
                            },
                            child: const Text("Create account",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 89, 86, 233),
                                  fontFamily: "Rale",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
