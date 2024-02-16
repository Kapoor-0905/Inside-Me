import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDbServices {
  final String? uid;
  FirebaseDbServices({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // saving user data
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "uid": uid,
    });
  }

  // gettimg user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
