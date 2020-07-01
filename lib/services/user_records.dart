import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});
  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  Future updateUserData(String name, String email) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'id':uid,
    });
  }
}
