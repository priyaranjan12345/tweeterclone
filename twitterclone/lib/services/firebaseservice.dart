import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> checkInternetConnection() async {
  bool isConnected = false;
  try {
    final result = await InternetAddress.lookup('www.google.co.in');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    return isConnected;
  }
  return isConnected;
}

Future<bool> signUp(String email, String password) async {
  bool hasNet = await checkInternetConnection();
  bool isSignup = false;

  if (hasNet) {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isSignup = true;
      });
    } catch (e) {
      //print('sign up error: ${e}');
    }
  }
  return isSignup;
}

Future<bool> signIn(String email, String password) async {
  bool hasNet = await checkInternetConnection();
  bool isValidate = false;

  if (hasNet) {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isValidate = true;
      });
    } catch (e) {
      //print('sign in error: ${e}');
    }
  }
  return isValidate;
}

Future<bool> logout() async {
  bool islogout = false;
  try {
    await auth.signOut().then(
      (value) {
        islogout = true;
      },
    );
  } catch (e) {
    //print('logout error: ${e}');
  }
  return islogout;
}

Future<bool> isSignedIn() async {
  var isloggedin = false;
  if (FirebaseAuth.instance.currentUser != null) {
    isloggedin = true;
  }
  return isloggedin;
}

myEmail() {
  var email = auth.currentUser.email;
  return email;
}

Future<void> insertData(String msg) async {
  try {
    DateTime now = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      "created_date": now,
      "last_modified_date": now,
      "message": msg,
    };
    await firestore.collection("twitted_data").add(data);
  } catch (e) {
    //print('insert error: ${e}');
  }
}

Future<bool> updateData(String udoc, String msg) async {
  bool isupdated = false;
  try {
    DateTime now = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      "last_modified_date": now,
      "message": msg,
    };
    await firestore
        .collection("twitted_data")
        .doc(udoc)
        .update(data)
        .then((value) => isupdated = true);
  } catch (e) {
    //print('update error: ${e}');
  }
  return isupdated;
}

Future<bool> deleteData(String udoc) async {
  bool isdatadeleted = false;
  try {
    await firestore
        .collection("twitted_data")
        .doc(udoc)
        .delete()
        .then((value) => isdatadeleted = true);
  } catch (e) {
    //print('delete error: ${e}');
  }
  return isdatadeleted;
}
