import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voice_translate/service/database.dart';
import 'package:voice_translate/service/flutterfire.dart';
import 'dart:io';

import '../widgets/my_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey();
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();
  Map<String, dynamic> data = {};
  String profilePicLink = "";
  bool _passwordVisible = false;

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child("profilepic" + getUid() + ".jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        DatabaseService(uid: getUid()).updateImage(profilePicLink);
        print(value);
      });
    });
  }

  @override
  void initState() {
    DatabaseService(uid: getUid()).getData().then((value) {
      setState(() {
        data = value.data() as Map<String, dynamic>;
        firstNameController.text = data["firstName"];
        lastNameController.text = data["lastName"];
        emailController.text = getEmail()!;
        profilePicLink = data["image"];
      });
    });

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 89, 86, 233),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text("Profile",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              Container(
                color: const Color.fromARGB(255, 89, 86, 233),
                height: 122,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: GestureDetector(
                    key: key,
                    onTap: () async {
                      pickUploadProfilePic();
                    },
                    child: //Icon(Icons.person,size: 100,)
                        CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        profilePicLink,
                      ),
                    )),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 32, 8, 0),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  //contentPadding: EdgeInsets.only(left:20,top:24),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "First name",
                  labelText: "First name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
              child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Last name",
                  labelText: "Last name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "E-mail",
                  labelText: "E-mail",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
              child: TextFormField(
                obscureText: !_passwordVisible,
                controller: passwordNameController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Password",
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2, //<-- SEE HERE
                      color: Color.fromARGB(255, 89, 86, 233),
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * .75,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      DatabaseService(uid: getUid())
                          .updateFirstName(firstNameController.text);
                      DatabaseService(uid: getUid())
                          .updateLastName(lastNameController.text);
                      //resetPassword("azerty96123");
                      if (getEmail() != emailController.text) {
                        resetEmail(emailController.text);
                        DatabaseService(uid: getUid())
                            .updateEmail(emailController.text);
                      }
                      if (passwordNameController.text != "") {
                        resetPassword(passwordNameController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 89, 86, 233),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- Radius
                      ),
                    ),
                    child: const Text(
                      'Save',
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
    );
  }
}
