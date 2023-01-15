
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_translate/service/database.dart';


Future<String> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    bool verify = FirebaseAuth.instance.currentUser!.emailVerified;

    return "success";
  } catch (e) {
    print(e);
    return e.toString();
  }
}

Future<String?> register(String email, String password) async {
  
  try {
     UserCredential result =await FirebaseAuth.instance
         .createUserWithEmailAndPassword(email: email, password: password);
        

    
    User? user = result.user;
    await DatabaseService(uid: user!.uid).updateUserData("", "", email, [],[],"https://riverlegacy.org/wp-content/uploads/2021/07/blank-profile-photo.jpeg");
    //return true;
    return "success";
  } on FirebaseAuthException catch (e) {
    
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 'The password provided is too weak.';
      
    } else if (e.code == 'email-already-in-use') {
      
      print('The account already exists for that email.');
      return 'The account already exists for that email.';
      
    }
    //return false;
  } catch (e) {
    print(e.toString());
    return e.toString();
    //return false;
  }
}

void verify() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}
String getUid(){
  return FirebaseAuth.instance.currentUser!.uid; 
}
String? getEmail(){
  return FirebaseAuth.instance.currentUser!.email; 
}

void forgetPassword(String email){
  FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
void resetPassword(String password){
  FirebaseAuth.instance.currentUser!.updatePassword(password);
}
void resetEmail(String email){
  FirebaseAuth.instance.currentUser!.updateEmail(email);
}
void signOut(){
  FirebaseAuth.instance.signOut();
}


/*Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      }
      double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}*/
