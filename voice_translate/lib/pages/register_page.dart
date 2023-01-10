import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:voice_translate/pages/verify_page.dart';
import 'package:voice_translate/widgets/alert_box.dart';

import '../service/flutterfire.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControllerEnter = TextEditingController();
  TextEditingController passwordControllerConfirm = TextEditingController();
  bool isObscureEnter = true;
  bool isObscureConfirm = true;
  String passwordStateEnter = "Show";
  String passwordStateConfirm = "Show";
  bool validEmail = true;
  bool validPasswordEnter = true;
  bool validPasswordConfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      //key: _formKey,
      backgroundColor: const Color.fromARGB(255, 89, 86, 233),
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
                  """Create your
account""",
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 36, left: 48),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 48, top: 32),
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
                            cursorColor: Color.fromARGB(255, 89, 86, 233),
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
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/Lock.png",
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Text(
                                "Enter your password",
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
                                validPasswordEnter = false;
                                return "Enter a valid Password please.";
                              } else {
                                validPasswordEnter = true;
                              }
                              return null;
                            },
                            controller: passwordControllerEnter,
                            obscureText: isObscureEnter,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (passwordStateEnter == "Show") {
                                      passwordStateEnter = "Hide";
                                      isObscureEnter = false;
                                    } else {
                                      passwordStateEnter = "Show";
                                      isObscureEnter = true;
                                    }
                                  });
                                },
                                child: Text(passwordStateEnter,
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
                            cursorColor: Color.fromARGB(255, 89, 86, 233),
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
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/Lock.png",
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              const Text(
                                "Confirm your password",
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
                                validPasswordConfirm = false;
                                return "Enter a valid confirmation Password please.";
                              } else if (passwordControllerConfirm.text !=
                                  passwordControllerEnter.text) {
                                validPasswordConfirm = false;
                                return "Confirmation Password doesn't match.";
                              } else {
                                validPasswordConfirm = true;
                              }
                              return null;
                            },
                            controller: passwordControllerConfirm,
                            obscureText: isObscureConfirm,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (passwordStateConfirm == "Show") {
                                      passwordStateConfirm = "Hide";
                                      isObscureConfirm = false;
                                    } else {
                                      passwordStateConfirm = "Show";
                                      isObscureConfirm = true;
                                    }
                                  });
                                },
                                child: Text(passwordStateConfirm,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 89, 86, 233),
                                      fontFamily: "Rale",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              hintText: "Re-enter your Password",
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
                            cursorColor: Color.fromARGB(255, 89, 86, 233),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Rale",
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: Center(
                            child: SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width * .75,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await register(emailController.text,
                                            passwordControllerConfirm.text)
                                        .then((test) {
                                      if (test !="success") {
                                        alertBoxDetail(
                                            context, "Failed!", test!);
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const VerifyScreen()));
                                      }
                                      
                                    });
                                  }

                                  //verify();
                                  /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );*/
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
                                  'Sign Up',
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
                      ],
                    ),
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
