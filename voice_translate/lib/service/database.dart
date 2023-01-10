import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


  Future<void> updateUserData(String firstName,String lastName, String email, List<List<String>> history,List<List<String>> favorite,String image) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName':lastName,
      'history':history,
      'email': email,
      'favorite':favorite,
      'image':image
    },);
  }

  Future<void> updateHistory(List<dynamic> history) async {
    return await userCollection.doc(uid).set({
      'history':history,
    },SetOptions(merge: true));
  }
  Future<void> updateFavorite(List<dynamic> favorite) async {
    return await userCollection.doc(uid).set({
      'favorite':favorite,
    },SetOptions(merge: true));
  }
  Future<void> updateFirstName(String firstName) async {
    return await userCollection.doc(uid).set({
      'firstName':firstName,
    },SetOptions(merge: true));
  }
  Future<void> updateLastName(String lastName) async {
    return await userCollection.doc(uid).set({
      'lastName':lastName,
    },SetOptions(merge: true));
  }
  Future<void> updateImage(String image) async {
    return await userCollection.doc(uid).set({
      'image':image,
    },SetOptions(merge: true));
  }
  Future<void> updateEmail(String email) async {
    return await userCollection.doc(uid).set({
      'email':email,
    },SetOptions(merge: true));
  }


  Future<DocumentSnapshot> getData()async {
    return await userCollection.doc(uid).get();
  }

}